<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Qr\QrPayRequest;
use App\Http\Requests\Qr\ResolveQrRequest;
use App\Services\QrService;
use App\Services\TransactionService;
use App\Support\ApiResponse;

class QrController extends Controller
{
    use ApiResponse;

    public function __construct(
        private readonly QrService $qrService,
        private readonly TransactionService $transactionService,
    ) {
    }

    public function myCode()
    {
        return $this->success([
            'payload' => $this->qrService->myPayload(auth()->user()),
        ]);
    }

    public function resolveCode(ResolveQrRequest $request)
    {
        return $this->success($this->qrService->resolve($request->validated('qr_payload')));
    }

    public function pay(QrPayRequest $request)
    {
        $resolved = $this->qrService->resolve($request->validated('qr_payload'));
        $tx = $this->transactionService->transfer(
            auth()->id(),
            (string) ($resolved['phone'] ?? ''),
            (float) $request->validated('amount'),
            $request->validated('description') ?? 'QR payment'
        );

        return $this->success($tx, 'QR payment successful.');
    }
}
