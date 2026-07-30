<?php

namespace App\Repositories\Contracts;

use App\Models\Wallet;

interface WalletRepositoryInterface
{
    public function byUserId(int $userId): ?Wallet;
    public function createForUser(int $userId): Wallet;
    public function save(Wallet $wallet): bool;
}
