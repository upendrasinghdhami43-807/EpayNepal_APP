<?php

namespace App\Jobs;

use App\Integrations\Email\EmailGatewayInterface;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;

class SendEmailNotificationJob implements ShouldQueue
{
    use Queueable;

    public function __construct(
        public string $to,
        public string $subject,
        public string $body,
    ) {
    }

    public function handle(EmailGatewayInterface $emailGateway): void
    {
        $emailGateway->send($this->to, $this->subject, $this->body);
    }
}
