<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Wallet\TopUpRequest;
use App\Http\Requests\Wallet\WithdrawRequest;
use App\Services\WalletService;
use App\Support\ApiResponse;

class WalletController extends Controller
{
    use ApiResponse;

    public function __construct(private readonly WalletService $walletService)
    {
    }

    public function balance()
    {
        $wallet = $this->walletService->balance(auth()->id());

        return $this->success($wallet);
    }

    public function topUp(TopUpRequest $request)
    {
        $wallet = $this->walletService->balance(auth()->id());
        $tx = $this->walletService->credit((int) $wallet->id, (float) $request->validated('amount'), 'TOP_UP', 'Wallet top-up');

        return $this->success($tx, 'Top-up successful.');
    }

    public function withdraw(WithdrawRequest $request)
    {
        $wallet = $this->walletService->balance(auth()->id());
        $tx = $this->walletService->debit((int) $wallet->id, (float) $request->validated('amount'), 'WITHDRAW', 'Wallet withdrawal');

        return $this->success($tx, 'Withdrawal successful.');
    }
}
