<?php

namespace App\Services;

use App\Jobs\SendPushNotificationJob;
use App\Models\Notification;

class NotificationService
{
    public function store(int $userId, string $title, string $body, string $type = 'system', array $data = []): Notification
    {
        $notification = Notification::create([
            'user_id' => $userId,
            'title' => $title,
            'body' => $body,
            'type' => $type,
            'data' => $data,
            'is_read' => false,
        ]);

        SendPushNotificationJob::dispatch($userId, $title, $body, $data);

        return $notification;
    }
}
