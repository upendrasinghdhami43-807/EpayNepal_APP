<?php

namespace App\Integrations\Push;

use App\Models\Device;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class FcmPushGateway implements PushGatewayInterface
{
    public function sendToUser(int $userId, string $title, string $body, array $data = []): void
    {
        $tokens = Device::query()
            ->where('user_id', $userId)
            ->where('is_active', true)
            ->whereNotNull('fcm_token')
            ->pluck('fcm_token')
            ->filter()
            ->values();

        if ($tokens->isEmpty()) {
            return;
        }

        $endpoint = (string) config('services.fcm.endpoint', '');
        $serverKey = (string) config('services.fcm.server_key', '');

        if ($endpoint === '' || $serverKey === '') {
            Log::info('fcm_gateway_log', [
                'user_id' => $userId,
                'tokens' => $tokens->count(),
                'title' => $title,
                'body' => $body,
                'data' => $data,
            ]);

            return;
        }

        foreach ($tokens as $token) {
            Http::withToken($serverKey)
                ->timeout(8)
                ->post($endpoint, [
                    'to' => $token,
                    'notification' => [
                        'title' => $title,
                        'body' => $body,
                    ],
                    'data' => $data,
                ]);
        }
    }
}
