<?php

namespace App\Integrations\Email;

interface EmailGatewayInterface
{
    public function send(string $to, string $subject, string $body): void;
}
