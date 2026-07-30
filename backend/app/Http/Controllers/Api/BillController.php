<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Bill\BillPaymentRequest;
use App\Services\BillService;
use App\Support\ApiResponse;

class BillController extends Controller
{
    use ApiResponse;

    public function __construct(private readonly BillService $billService)
    {
    }

    public function mobileRecharge(BillPaymentRequest $request)
    {
        return $this->success($this->billService->pay('mobile_recharge', auth()->id(), (float) $request->validated('amount'), $request->validated()), 'Mobile recharge paid.');
    }

    public function electricity(BillPaymentRequest $request)
    {
        return $this->success($this->billService->pay('electricity', auth()->id(), (float) $request->validated('amount'), $request->validated()), 'Electricity bill paid.');
    }

    public function internet(BillPaymentRequest $request)
    {
        return $this->success($this->billService->pay('internet', auth()->id(), (float) $request->validated('amount'), $request->validated()), 'Internet bill paid.');
    }

    public function water(BillPaymentRequest $request)
    {
        return $this->success($this->billService->pay('water', auth()->id(), (float) $request->validated('amount'), $request->validated()), 'Water bill paid.');
    }
}
