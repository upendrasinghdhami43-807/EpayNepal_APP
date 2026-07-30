<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Kyc\KycFileUploadRequest;
use App\Http\Requests\Kyc\KycSubmitRequest;
use App\Models\KycRequest;
use App\Services\KycService;
use App\Support\ApiResponse;

class KycController extends Controller
{
    use ApiResponse;

    public function __construct(private readonly KycService $kycService)
    {
    }

    public function status()
    {
        $row = KycRequest::where('user_id', auth()->id())->latest('id')->first();

        return $this->success($row ?? ['status' => 'none']);
    }

    public function submit(KycSubmitRequest $request)
    {
        $kyc = $this->kycService->upsert(auth()->id(), $request->validated());

        return $this->success($kyc, 'KYC submitted.');
    }

    public function uploadDocument(KycFileUploadRequest $request)
    {
        $url = $this->kycService->upload($request->file('file'), $request->validated('type'), auth()->id());

        return $this->success(['url' => $url], 'File uploaded.');
    }

    public function uploadSelfie(KycFileUploadRequest $request)
    {
        $url = $this->kycService->upload($request->file('file'), 'selfie', auth()->id());

        return $this->success(['url' => $url], 'Selfie uploaded.');
    }
}
