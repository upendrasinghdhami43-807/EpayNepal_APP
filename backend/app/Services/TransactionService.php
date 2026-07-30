<?php

namespace App\Services;

use App\Events\TransactionCompleted;
use App\Models\Transaction;
use App\Models\User;
use App\Models\Wallet;
use Illuminate\Support\Facades\DB;

class TransactionService
{
    public function transfer(int $senderUserId, string $recipientPhone, float $amount, ?string $description): Transaction
    {
        return DB::transaction(function () use ($senderUserId, $recipientPhone, $amount, $description) {
            $senderWallet = Wallet::where('user_id', $senderUserId)->lockForUpdate()->firstOrFail();
            $recipientUser = User::where('phone', $recipientPhone)->firstOrFail();
            $recipientWallet = Wallet::where('user_id', $recipientUser->id)->lockForUpdate()->firstOrFail();

            if ((float) $senderWallet->balance < $amount) {
                throw new \RuntimeException('Insufficient balance.');
            }

            $senderWallet->balance = (float) $senderWallet->balance - $amount;
            $recipientWallet->balance = (float) $recipientWallet->balance + $amount;
            $senderWallet->save();
            $recipientWallet->save();

            $tx = Transaction::create([
                'reference_id' => strtoupper((string) str()->uuid()),
                'sender_wallet_id' => $senderWallet->id,
                'receiver_wallet_id' => $recipientWallet->id,
                'type' => 'P2P',
                'amount' => $amount,
                'fee' => 0,
                'status' => 'completed',
                'description' => $description,
                'metadata' => ['recipient_phone' => $recipientPhone],
            ]);

            event(new TransactionCompleted($tx));

            return $tx;
        });
    }
}
