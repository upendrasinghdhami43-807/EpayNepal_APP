<?php

namespace App\Jobs;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Support\Facades\Log;

class SendOtpSmsJob implements ShouldQueue
{
    use Queueable;

    public function __construct(public string $phone, public string $otp)
    {
    }

    public function handle(): void
    {
        Log::info('otp_sms_job', [
            'phone' => $this->phone,
            'otp' => $this->otp,
        ]);
    }
}
