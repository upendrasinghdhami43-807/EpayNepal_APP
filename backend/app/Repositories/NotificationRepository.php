<?php

namespace App\Repositories;

use App\Models\Notification;
use App\Repositories\Contracts\NotificationRepositoryInterface;
use Illuminate\Database\Eloquent\Collection;

class NotificationRepository implements NotificationRepositoryInterface
{
    public function listByUser(int $userId): Collection
    {
        return Notification::where('user_id', $userId)->latest('id')->get();
    }

    public function markRead(int $userId, int $id): bool
    {
        return Notification::where('user_id', $userId)
            ->where('id', $id)
            ->update(['is_read' => true, 'read_at' => now()]) > 0;
    }

    public function markAllRead(int $userId): int
    {
        return Notification::where('user_id', $userId)
            ->where('is_read', false)
            ->update(['is_read' => true, 'read_at' => now()]);
    }
}
