<?php

namespace App\Jobs;

use App\Integrations\Sms\SmsGatewayInterface;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;

class SendOtpSmsJob implements ShouldQueue
{
    use Queueable;

    public function __construct(public string $phone, public string $otp)
    {
    }

    public function handle(SmsGatewayInterface $smsGateway): void
    {
        $smsGateway->sendOtp($this->phone, $this->otp);
    }
}
