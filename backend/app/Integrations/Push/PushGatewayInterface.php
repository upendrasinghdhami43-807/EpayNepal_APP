<?php

namespace App\Integrations\Push;

interface PushGatewayInterface
{
    public function sendToUser(int $userId, string $title, string $body, array $data = []): void;
}
