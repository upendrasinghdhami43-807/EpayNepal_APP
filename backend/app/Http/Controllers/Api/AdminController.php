<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AdminUser;
use App\Models\KycRequest;
use App\Models\Transaction;
use App\Models\User;
use App\Services\ReportService;
use App\Services\SettingService;
use App\Support\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AdminController extends Controller
{
    use ApiResponse;

    public function __construct(
        private readonly ReportService $reportService,
        private readonly SettingService $settingService,
    ) {
    }

    public function login(Request $request)
    {
        $data = $request->validate([
            'email' => ['required', 'email'],
            'password' => ['required', 'string'],
        ]);

        $admin = AdminUser::where('email', $data['email'])->first();
        if (!$admin || !Hash::check($data['password'], (string) $admin->password_hash)) {
            return $this->error('INVALID_CREDENTIALS', 'Invalid credentials.', 401);
        }

        $token = $admin->createToken('admin', ['admin'])->plainTextToken;

        return $this->success(['token' => $token, 'admin' => $admin], 'Admin login successful.');
    }

    public function logout(Request $request)
    {
        $request->user()?->currentAccessToken()?->delete();

        return $this->success(null, 'Admin logged out.');
    }

    public function dashboard()
    {
        return $this->success($this->reportService->dashboard());
    }

    public function users()
    {
        return $this->success(User::latest('id')->paginate(20));
    }

    public function freeze(int $id)
    {
        $user = User::find($id);
        if (!$user) {
            return $this->error('NOT_FOUND', 'User not found.', 404);
        }

        $user->status = 'frozen';
        $user->save();

        return $this->success($user, 'User frozen.');
    }

    public function unfreeze(int $id)
    {
        $user = User::find($id);
        if (!$user) {
            return $this->error('NOT_FOUND', 'User not found.', 404);
        }

        $user->status = 'active';
        $user->save();

        return $this->success($user, 'User unfrozen.');
    }

    public function transactions()
    {
        return $this->success(Transaction::latest('id')->paginate(20));
    }

    public function kycQueue()
    {
        return $this->success(KycRequest::where('status', 'pending')->latest('id')->paginate(20));
    }

    public function approveKyc(int $id)
    {
        $kyc = KycRequest::find($id);
        if (!$kyc) {
            return $this->error('NOT_FOUND', 'KYC request not found.', 404);
        }

        $kyc->status = 'approved';
        $kyc->reviewed_at = now();
        $kyc->save();

        return $this->success($kyc, 'KYC approved.');
    }

    public function rejectKyc(Request $request, int $id)
    {
        $data = $request->validate([
            'reason' => ['required', 'string', 'max:255'],
        ]);

        $kyc = KycRequest::find($id);
        if (!$kyc) {
            return $this->error('NOT_FOUND', 'KYC request not found.', 404);
        }

        $kyc->status = 'rejected';
        $kyc->rejection_reason = $data['reason'];
        $kyc->reviewed_at = now();
        $kyc->save();

        return $this->success($kyc, 'KYC rejected.');
    }

    public function reports()
    {
        return $this->success($this->reportService->dashboard());
    }

    public function settings()
    {
        return $this->success($this->settingService->all());
    }

    public function updateSettings(Request $request)
    {
        $this->settingService->upsert($request->all());

        return $this->success(null, 'Settings updated.');
    }
}
