<?php

namespace App\Repositories;

use App\Models\Wallet;
use App\Repositories\Contracts\WalletRepositoryInterface;

class WalletRepository implements WalletRepositoryInterface
{
    public function byUserId(int $userId): ?Wallet
    {
        return Wallet::where('user_id', $userId)->first();
    }

    public function createForUser(int $userId): Wallet
    {
        return Wallet::create([
            'user_id' => $userId,
            'balance' => 0,
            'currency' => 'NPR',
            'is_active' => true,
        ]);
    }

    public function save(Wallet $wallet): bool
    {
        return $wallet->save();
    }
}
