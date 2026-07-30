<?php

namespace App\Jobs;

use App\Integrations\Push\PushGatewayInterface;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;

class SendPushNotificationJob implements ShouldQueue
{
    use Queueable;

    public function __construct(
        public int $userId,
        public string $title,
        public string $body,
        public array $data = []
    ) {
    }

    public function handle(PushGatewayInterface $pushGateway): void
    {
        $pushGateway->sendToUser($this->userId, $this->title, $this->body, $this->data);
    }
}
