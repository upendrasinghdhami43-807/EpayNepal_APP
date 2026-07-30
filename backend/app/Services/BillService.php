<?php

namespace App\Services;

class BillService
{
    public function pay(string $type, int $userId, float $amount, array $meta = []): array
    {
        return [
            'bill_type' => $type,
            'user_id' => $userId,
            'amount' => number_format($amount, 2, '.', ''),
            'status' => 'completed',
            'provider_reference' => strtoupper((string) str()->uuid()),
            'meta' => $meta,
        ];
    }
}
