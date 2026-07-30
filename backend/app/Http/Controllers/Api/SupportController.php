<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Support\CreateTicketRequest;
use App\Http\Requests\Support\ReplyTicketRequest;
use App\Models\SupportTicket;
use App\Services\SupportService;
use App\Support\ApiResponse;

class SupportController extends Controller
{
    use ApiResponse;

    public function __construct(private readonly SupportService $supportService)
    {
    }

    public function store(CreateTicketRequest $request)
    {
        $ticket = $this->supportService->createTicket(auth()->id(), $request->validated());

        return $this->success($ticket, 'Ticket created.', 201);
    }

    public function index()
    {
        return $this->success(SupportTicket::where('user_id', auth()->id())->latest('id')->get());
    }

    public function show(int $id)
    {
        $ticket = SupportTicket::where('user_id', auth()->id())->where('id', $id)->first();
        if (!$ticket) {
            return $this->error('NOT_FOUND', 'Ticket not found.', 404);
        }

        return $this->success($ticket);
    }

    public function reply(ReplyTicketRequest $request, int $id)
    {
        $ticket = SupportTicket::where('user_id', auth()->id())->where('id', $id)->first();
        if (!$ticket) {
            return $this->error('NOT_FOUND', 'Ticket not found.', 404);
        }

        $message = $this->supportService->reply($ticket->id, auth()->id(), $request->validated('message'));

        return $this->success($message, 'Reply added.');
    }
}
