<?php

namespace App\Services;

use App\Models\Merchant;
use App\Models\MerchantQr;

class MerchantService
{
    public function register(int $userId, array $payload): Merchant
    {
        return Merchant::create([
            'user_id' => $userId,
            'business_name' => $payload['business_name'],
            'business_type' => $payload['business_type'] ?? null,
            'pan_number' => $payload['pan_number'] ?? null,
            'address' => $payload['address'] ?? null,
            'is_active' => true,
        ]);
    }

    public function qrPayload(Merchant $merchant): string
    {
        $payload = sprintf('epaynepal://merchant/%d?name=%s', $merchant->id, urlencode($merchant->business_name));

        MerchantQr::create([
            'merchant_id' => $merchant->id,
            'qr_code' => strtoupper((string) str()->uuid()),
            'qr_payload' => $payload,
            'is_active' => true,
            'created_at' => now(),
        ]);

        return $payload;
    }
}
