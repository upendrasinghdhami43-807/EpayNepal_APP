<?php

namespace App\Services;

use App\Jobs\SendOtpSmsJob;
use App\Models\OtpCode;
use App\Models\User;
use App\Repositories\Contracts\WalletRepositoryInterface;
use Illuminate\Support\Facades\Hash;

class AuthService
{
    public function __construct(private readonly WalletRepositoryInterface $walletRepository)
    {
    }

    public function register(array $data): User
    {
        $user = User::create([
            'name' => $data['name'],
            'phone' => $data['phone'],
            'email' => $data['email'] ?? null,
            'password' => Hash::make($data['password']),
            'status' => 'active',
            'kyc_level' => 'none',
        ]);

        $this->walletRepository->createForUser($user->id);
        $this->issueOtp($user->phone, 'register', $user->id);

        return $user;
    }

    public function issueOtp(string $phone, string $purpose, ?int $userId = null): void
    {
        $otp = (string) random_int(100000, 999999);

        OtpCode::create([
            'user_id' => $userId,
            'phone' => $phone,
            'code_hash' => Hash::make($otp),
            'purpose' => $purpose,
            'attempts' => 0,
            'expires_at' => now()->addMinutes(5),
            'is_used' => false,
        ]);

        SendOtpSmsJob::dispatch($phone, $otp);
    }

    public function verifyOtp(string $phone, string $code, string $purpose): bool
    {
        $otp = OtpCode::query()
            ->where('phone', $phone)
            ->where('purpose', $purpose)
            ->where('is_used', false)
            ->latest('id')
            ->first();

        if (!$otp || now()->greaterThan($otp->expires_at)) {
            return false;
        }

        $valid = Hash::check($code, $otp->code_hash);

        $otp->attempts++;
        if ($valid) {
            $otp->is_used = true;
        }
        $otp->save();

        return $valid;
    }
}
