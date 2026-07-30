<?php

namespace App\Jobs;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;
use Illuminate\Support\Facades\Log;

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

    public function handle(): void
    {
        Log::info('push_notification_job', [
            'user_id' => $this->userId,
            'title' => $this->title,
            'body' => $this->body,
            'data' => $this->data,
        ]);
    }
}
