<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Repositories\Contracts\NotificationRepositoryInterface;
use App\Support\ApiResponse;

class NotificationController extends Controller
{
    use ApiResponse;

    public function __construct(private readonly NotificationRepositoryInterface $notificationRepository)
    {
    }

    public function index()
    {
        return $this->success($this->notificationRepository->listByUser(auth()->id()));
    }

    public function markRead(int $id)
    {
        $ok = $this->notificationRepository->markRead(auth()->id(), $id);

        return $ok
            ? $this->success(null, 'Notification marked read.')
            : $this->error('NOT_FOUND', 'Notification not found.', 404);
    }

    public function markAllRead()
    {
        $count = $this->notificationRepository->markAllRead(auth()->id());

        return $this->success(['updated' => $count], 'Notifications updated.');
    }
}
