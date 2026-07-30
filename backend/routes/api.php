<?php

use App\Http\Controllers\Api\AdminController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\BillController;
use App\Http\Controllers\Api\KycController;
use App\Http\Controllers\Api\MerchantController;
use App\Http\Controllers\Api\NotificationController;
use App\Http\Controllers\Api\QrController;
use App\Http\Controllers\Api\SupportController;
use App\Http\Controllers\Api\TransactionController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\WalletController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {
    Route::prefix('auth')->middleware('throttle:6,1')->group(function () {
        Route::post('/register', [AuthController::class, 'register']);
        Route::post('/verify-otp', [AuthController::class, 'verifyOtp']);
        Route::post('/resend-otp', [AuthController::class, 'resendOtp']);
        Route::post('/login', [AuthController::class, 'login']);
        Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
        Route::post('/reset-password', [AuthController::class, 'resetPassword']);
    });

    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/auth/logout', [AuthController::class, 'logout']);
        Route::post('/auth/set-pin', [AuthController::class, 'setPin']);
        Route::post('/auth/verify-pin', [AuthController::class, 'verifyPin']);
        Route::post('/auth/change-password', [AuthController::class, 'changePassword']);
        Route::post('/auth/change-pin', [AuthController::class, 'changePin'])->middleware('pin');

        Route::get('/user/profile', [UserController::class, 'show']);
        Route::put('/user/profile', [UserController::class, 'update']);
        Route::post('/user/devices', [UserController::class, 'registerDevice']);

        Route::get('/wallet/balance', [WalletController::class, 'balance']);
        Route::post('/wallet/top-up', [WalletController::class, 'topUp'])->middleware('pin');
        Route::post('/wallet/withdraw', [WalletController::class, 'withdraw'])->middleware('pin');

        Route::post('/transactions/send-money', [TransactionController::class, 'sendMoney'])->middleware('pin');
        Route::get('/transactions', [TransactionController::class, 'index']);
        Route::get('/transactions/{id}', [TransactionController::class, 'show']);

        Route::get('/qr/my-code', [QrController::class, 'myCode']);
        Route::post('/qr/resolve', [QrController::class, 'resolveCode']);
        Route::post('/qr/pay', [QrController::class, 'pay'])->middleware('pin');

        Route::post('/bills/mobile-recharge', [BillController::class, 'mobileRecharge'])->middleware('pin');
        Route::post('/bills/electricity', [BillController::class, 'electricity'])->middleware('pin');
        Route::post('/bills/internet', [BillController::class, 'internet'])->middleware('pin');
        Route::post('/bills/water', [BillController::class, 'water'])->middleware('pin');

        Route::get('/kyc/status', [KycController::class, 'status']);
        Route::post('/kyc/submit', [KycController::class, 'submit']);
        Route::post('/kyc/upload-document', [KycController::class, 'uploadDocument']);
        Route::post('/kyc/upload-selfie', [KycController::class, 'uploadSelfie']);

        Route::post('/merchants/register', [MerchantController::class, 'register']);
        Route::get('/merchants/{merchantId}/qr', [MerchantController::class, 'qr']);

        Route::get('/notifications', [NotificationController::class, 'index']);
        Route::put('/notifications/{id}/read', [NotificationController::class, 'markRead']);
        Route::put('/notifications/read-all', [NotificationController::class, 'markAllRead']);

        Route::post('/support/tickets', [SupportController::class, 'store']);
        Route::get('/support/tickets', [SupportController::class, 'index']);
        Route::get('/support/tickets/{id}', [SupportController::class, 'show']);
        Route::post('/support/tickets/{id}/reply', [SupportController::class, 'reply']);
    });

    Route::post('/admin/auth/login', [AdminController::class, 'login']);

    Route::prefix('admin')->middleware(['auth:sanctum', 'abilities:admin'])->group(function () {
        Route::post('/auth/logout', [AdminController::class, 'logout']);
        Route::get('/dashboard', [AdminController::class, 'dashboard']);
        Route::get('/users', [AdminController::class, 'users']);
        Route::post('/users/{id}/freeze', [AdminController::class, 'freeze']);
        Route::post('/users/{id}/unfreeze', [AdminController::class, 'unfreeze']);
        Route::get('/transactions', [AdminController::class, 'transactions']);
        Route::get('/kyc', [AdminController::class, 'kycQueue']);
        Route::post('/kyc/{id}/approve', [AdminController::class, 'approveKyc']);
        Route::post('/kyc/{id}/reject', [AdminController::class, 'rejectKyc']);
        Route::get('/reports', [AdminController::class, 'reports']);
        Route::get('/settings', [AdminController::class, 'settings']);
        Route::put('/settings', [AdminController::class, 'updateSettings']);
    });
});
