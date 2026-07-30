<?php

namespace App\Integrations\Sms;

interface SmsGatewayInterface
{
    public function sendOtp(string $phone, string $otp): void;

    public function sendMessage(string $phone, string $message): void;
}
