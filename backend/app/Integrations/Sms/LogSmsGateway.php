<?php

namespace App\Integrations\Sms;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class LogSmsGateway implements SmsGatewayInterface
{
    public function sendOtp(string $phone, string $otp): void
    {
        $this->sendMessage($phone, sprintf('Your OTP is %s', $otp));
    }

    public function sendMessage(string $phone, string $message): void
    {
        $baseUrl = (string) config('services.sms.base_url', '');
        $apiKey = (string) config('services.sms.api_key', '');

        if ($baseUrl !== '' && $apiKey !== '') {
            Http::withToken($apiKey)
                ->timeout(8)
                ->post(rtrim($baseUrl, '/').'/messages', [
                    'to' => $phone,
                    'message' => $message,
                ]);

            return;
        }

        Log::info('sms_gateway_log', [
            'phone' => $phone,
            'message' => $message,
        ]);
    }
}
