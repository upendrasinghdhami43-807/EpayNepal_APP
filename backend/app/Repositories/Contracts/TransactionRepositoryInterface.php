<?php

namespace App\Repositories\Contracts;

use App\Models\Transaction;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

interface TransactionRepositoryInterface
{
    public function paginateForUser(int $walletId, int $perPage = 20): LengthAwarePaginator;
    public function findById(int $id): ?Transaction;
    public function create(array $payload): Transaction;
}
