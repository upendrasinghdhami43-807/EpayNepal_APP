<?php

namespace App\Services;

use App\Models\BillPayment;
use App\Models\RechargeHistory;
use App\Models\Wallet;
use RuntimeException;

class BillService
{
    public function __construct(private readonly WalletService $walletService)
    {
    }

    public function pay(string $type, int $userId, float $amount, array $meta = []): BillPayment|RechargeHistory
    {
        $wallet = Wallet::where('user_id', $userId)->first();
        if (!$wallet) {
            throw new RuntimeException('Wallet not found for this user.');
        }

        $cleanMeta = $meta;
        unset($cleanMeta['transaction_pin']);

        $transaction = $this->walletService->debit(
            (int) $wallet->id,
            $amount,
            strtoupper($type),
            'Bill payment: '.$type
        );

        $providerReference = strtoupper((string) str()->uuid());

        if ($type === 'mobile_recharge') {
            return RechargeHistory::create([
                'user_id' => $userId,
                'transaction_id' => $transaction->id,
                'phone' => (string) ($cleanMeta['consumer_number'] ?? ''),
                'operator' => $cleanMeta['provider'] ?? null,
                'amount' => $amount,
                'status' => 'completed',
                'metadata' => [
                    'provider_reference' => $providerReference,
                    'payload' => $cleanMeta,
                ],
            ]);
        }

        return BillPayment::create([
            'user_id' => $userId,
            'transaction_id' => $transaction->id,
            'bill_type' => $type,
            'provider' => $cleanMeta['provider'] ?? null,
            'consumer_number' => (string) ($cleanMeta['consumer_number'] ?? ''),
            'amount' => $amount,
            'status' => 'completed',
            'metadata' => [
                'provider_reference' => $providerReference,
                'payload' => $cleanMeta,
            ],
        ]);
    }
}
