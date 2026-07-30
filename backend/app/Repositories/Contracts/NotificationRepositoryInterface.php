<?php

namespace App\Repositories\Contracts;

use Illuminate\Database\Eloquent\Collection;

interface NotificationRepositoryInterface
{
    public function listByUser(int $userId): Collection;
    public function markRead(int $userId, int $id): bool;
    public function markAllRead(int $userId): int;
}
