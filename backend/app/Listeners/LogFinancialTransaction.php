<?php

namespace App\Listeners;

use App\Events\TransactionCompleted;
use App\Models\TransactionLog;

class LogFinancialTransaction
{
    public function handle(TransactionCompleted $event): void
    {
        $tx = $event->transaction;

        if ($tx->sender_wallet_id) {
            TransactionLog::create([
                'transaction_id' => $tx->id,
                'wallet_id' => $tx->sender_wallet_id,
                'action' => 'debit',
                'amount' => $tx->amount,
                'balance_before' => data_get($tx->metadata, 'balance_before', 0),
                'balance_after' => data_get($tx->metadata, 'balance_after', 0),
                'created_at' => now(),
            ]);
        }

        if ($tx->receiver_wallet_id) {
            TransactionLog::create([
                'transaction_id' => $tx->id,
                'wallet_id' => $tx->receiver_wallet_id,
                'action' => 'credit',
                'amount' => $tx->amount,
                'balance_before' => data_get($tx->metadata, 'balance_before', 0),
                'balance_after' => data_get($tx->metadata, 'balance_after', 0),
                'created_at' => now(),
            ]);
        }
    }
}
