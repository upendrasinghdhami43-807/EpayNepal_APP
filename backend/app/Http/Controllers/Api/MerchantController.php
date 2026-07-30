<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Merchant\RegisterMerchantRequest;
use App\Models\Merchant;
use App\Services\MerchantService;
use App\Support\ApiResponse;

class MerchantController extends Controller
{
    use ApiResponse;

    public function __construct(private readonly MerchantService $merchantService)
    {
    }

    public function register(RegisterMerchantRequest $request)
    {
        $merchant = $this->merchantService->register(auth()->id(), $request->validated());

        return $this->success($merchant, 'Merchant registered.', 201);
    }

    public function qr(int $merchantId)
    {
        $merchant = Merchant::find($merchantId);
        if (!$merchant) {
            return $this->error('NOT_FOUND', 'Merchant not found.', 404);
        }

        return $this->success([
            'merchant_id' => $merchant->id,
            'payload' => $this->merchantService->qrPayload($merchant),
        ]);
    }
}
