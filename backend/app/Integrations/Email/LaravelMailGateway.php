<?php

namespace App\Integrations\Email;

use Illuminate\Support\Facades\Mail;

class LaravelMailGateway implements EmailGatewayInterface
{
    public function send(string $to, string $subject, string $body): void
    {
        Mail::raw($body, function ($message) use ($to, $subject): void {
            $message->to($to)->subject($subject);
        });
    }
}
