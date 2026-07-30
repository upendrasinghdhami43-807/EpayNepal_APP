<?php

namespace App\Services;

use App\Events\TransactionCompleted;
use App\Models\Transaction;
use App\Models\Wallet;
use Illuminate\Support\Facades\DB;

class WalletService
{
    public function balance(int $userId): ?Wallet
    {
        return Wallet::where('user_id', $userId)->first();
    }

    public function credit(int $walletId, float $amount, string $type, string $description = ''): Transaction
    {
        return DB::transaction(function () use ($walletId, $amount, $type, $description) {
            $wallet = Wallet::whereKey($walletId)->lockForUpdate()->firstOrFail();
            $before = (float) $wallet->balance;
            $wallet->balance = $before + $amount;
            $wallet->save();

            $tx = Transaction::create([
                'reference_id' => strtoupper((string) str()->uuid()),
                'sender_wallet_id' => null,
                'receiver_wallet_id' => $wallet->id,
                'type' => $type,
                'amount' => $amount,
                'fee' => 0,
                'status' => 'completed',
                'description' => $description,
                'metadata' => ['balance_before' => $before, 'balance_after' => (float) $wallet->balance],
            ]);

            event(new TransactionCompleted($tx));

            return $tx;
        });
    }

    public function debit(int $walletId, float $amount, string $type, string $description = ''): Transaction
    {
        return DB::transaction(function () use ($walletId, $amount, $type, $description) {
            $wallet = Wallet::whereKey($walletId)->lockForUpdate()->firstOrFail();
            $before = (float) $wallet->balance;
            if ($before < $amount) {
                throw new \RuntimeException('Insufficient balance.');
            }

            $wallet->balance = $before - $amount;
            $wallet->save();

            $tx = Transaction::create([
                'reference_id' => strtoupper((string) str()->uuid()),
                'sender_wallet_id' => $wallet->id,
                'receiver_wallet_id' => null,
                'type' => $type,
                'amount' => $amount,
                'fee' => 0,
                'status' => 'completed',
                'description' => $description,
                'metadata' => ['balance_before' => $before, 'balance_after' => (float) $wallet->balance],
            ]);

            event(new TransactionCompleted($tx));

            return $tx;
        });
    }
}
