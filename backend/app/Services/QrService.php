<?php

namespace App\Services;

use App\Models\User;

class QrService
{
    public function myPayload(User $user): string
    {
        return sprintf('epaynepal://pay?to=%s&name=%s', $user->phone, urlencode($user->name));
    }

    public function resolve(string $payload): array
    {
        parse_str(parse_url($payload, PHP_URL_QUERY) ?? '', $params);

        return [
            'phone' => $params['to'] ?? null,
            'name' => urldecode($params['name'] ?? ''),
            'raw' => $payload,
        ];
    }
}
