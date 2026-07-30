<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Transaction\SendMoneyRequest;
use App\Models\Wallet;
use App\Repositories\Contracts\TransactionRepositoryInterface;
use App\Services\TransactionService;
use App\Support\ApiResponse;

class TransactionController extends Controller
{
    use ApiResponse;

    public function __construct(
        private readonly TransactionService $transactionService,
        private readonly TransactionRepositoryInterface $transactionRepository,
    ) {
    }

    public function sendMoney(SendMoneyRequest $request)
    {
        $tx = $this->transactionService->transfer(
            auth()->id(),
            $request->validated('recipient_phone'),
            (float) $request->validated('amount'),
            $request->validated('description')
        );

        return $this->success($tx, 'Transfer successful.');
    }

    public function index()
    {
        $walletId = (int) Wallet::where('user_id', auth()->id())->value('id');

        return $this->success($this->transactionRepository->paginateForUser($walletId));
    }

    public function show(int $id)
    {
        $tx = $this->transactionRepository->findById($id);
        if (!$tx) {
            return $this->error('NOT_FOUND', 'Transaction not found.', 404);
        }

        return $this->success($tx);
    }
}
