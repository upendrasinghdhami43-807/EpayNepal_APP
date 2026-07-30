<?php

namespace App\Services;

use App\Models\SupportMessage;
use App\Models\SupportTicket;

class SupportService
{
    public function createTicket(int $userId, array $payload): SupportTicket
    {
        return SupportTicket::create([
            'user_id' => $userId,
            'subject' => $payload['subject'],
            'category' => $payload['category'] ?? 'general',
            'status' => 'open',
            'priority' => $payload['priority'] ?? 'medium',
        ]);
    }

    public function reply(int $ticketId, int $senderId, string $message, string $senderType = 'user'): SupportMessage
    {
        return SupportMessage::create([
            'ticket_id' => $ticketId,
            'sender_id' => $senderId,
            'sender_type' => $senderType,
            'message' => $message,
        ]);
    }
}
