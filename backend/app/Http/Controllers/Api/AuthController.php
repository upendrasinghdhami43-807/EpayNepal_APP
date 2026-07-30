<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Http\Requests\Auth\OtpRequest;
use App\Http\Requests\Auth\PinRequest;
use App\Http\Requests\Auth\RegisterRequest;
use App\Models\User;
use App\Services\AuthService;
use App\Support\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    use ApiResponse;

    public function __construct(private readonly AuthService $authService)
    {
    }

    public function register(RegisterRequest $request)
    {
        $user = $this->authService->register($request->validated());

        return $this->success([
            'user_id' => $user->id,
            'phone' => $user->phone,
        ], 'Registered. OTP sent.', 201);
    }

    public function verifyOtp(OtpRequest $request)
    {
        $ok = $this->authService->verifyOtp(
            $request->validated('phone'),
            $request->validated('code'),
            $request->validated('purpose')
        );

        if (!$ok) {
            return $this->error('INVALID_OTP', 'OTP is invalid or expired.');
        }

        return $this->success(null, 'OTP verified.');
    }

    public function resendOtp(OtpRequest $request)
    {
        $this->authService->issueOtp(
            $request->validated('phone'),
            $request->validated('purpose')
        );

        return $this->success(null, 'OTP resent.');
    }

    public function login(LoginRequest $request)
    {
        $user = User::where('phone', $request->validated('phone'))->first();
        if (!$user || !Hash::check($request->validated('password'), $user->password)) {
            return $this->error('INVALID_CREDENTIALS', 'Phone or password is incorrect.', 401);
        }

        $token = $user->createToken($request->validated('device_name', 'mobile'))->plainTextToken;

        return $this->success([
            'token' => $token,
            'user' => $user,
        ], 'Login successful.');
    }

    public function logout(Request $request)
    {
        $request->user()?->currentAccessToken()?->delete();

        return $this->success(null, 'Logged out.');
    }

    public function setPin(PinRequest $request)
    {
        $user = $request->user();
        $user->pin_hash = Hash::make($request->validated('pin'));
        $user->save();

        return $this->success(null, 'Transaction PIN set.');
    }

    public function verifyPin(PinRequest $request)
    {
        $ok = Hash::check($request->validated('pin'), (string) $request->user()->pin_hash);

        if (!$ok) {
            return $this->error('INVALID_PIN', 'Invalid transaction PIN.');
        }

        return $this->success(null, 'PIN verified.');
    }

    public function forgotPassword(OtpRequest $request)
    {
        $this->authService->issueOtp($request->validated('phone'), 'reset_password');

        return $this->success(null, 'Reset OTP sent.');
    }

    public function resetPassword(Request $request)
    {
        $data = $request->validate([
            'phone' => ['required', 'regex:/^(98|97)\d{8}$/'],
            'code' => ['required', 'digits:6'],
            'password' => ['required', 'string', 'min:8'],
        ]);

        $ok = $this->authService->verifyOtp($data['phone'], $data['code'], 'reset_password');
        if (!$ok) {
            return $this->error('INVALID_OTP', 'OTP is invalid or expired.');
        }

        $user = User::where('phone', $data['phone'])->first();
        if (!$user) {
            return $this->error('USER_NOT_FOUND', 'User not found.', 404);
        }

        $user->password = Hash::make($data['password']);
        $user->save();

        return $this->success(null, 'Password reset successful.');
    }

    public function changePassword(Request $request)
    {
        $data = $request->validate([
            'current_password' => ['required', 'string'],
            'new_password' => ['required', 'string', 'min:8'],
        ]);

        $user = $request->user();
        if (!Hash::check($data['current_password'], (string) $user->password)) {
            return $this->error('INVALID_PASSWORD', 'Current password is incorrect.');
        }

        $user->password = Hash::make($data['new_password']);
        $user->save();

        return $this->success(null, 'Password changed.');
    }

    public function changePin(Request $request)
    {
        $data = $request->validate([
            'new_pin' => ['required', 'digits:4'],
            'transaction_pin' => ['required', 'digits:4'],
        ]);

        $user = $request->user();
        $user->pin_hash = Hash::make($data['new_pin']);
        $user->save();

        return $this->success(null, 'PIN changed.');
    }
}
