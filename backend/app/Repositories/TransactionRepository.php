<?php

namespace App\Repositories;

use App\Models\Transaction;
use App\Repositories\Contracts\TransactionRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class TransactionRepository implements TransactionRepositoryInterface
{
    public function paginateForUser(int $walletId, int $perPage = 20): LengthAwarePaginator
    {
        return Transaction::query()
            ->where('sender_wallet_id', $walletId)
            ->orWhere('receiver_wallet_id', $walletId)
            ->latest('id')
            ->paginate($perPage);
    }

    public function findById(int $id): ?Transaction
    {
        return Transaction::find($id);
    }

    public function create(array $payload): Transaction
    {
        return Transaction::create($payload);
    }
}
