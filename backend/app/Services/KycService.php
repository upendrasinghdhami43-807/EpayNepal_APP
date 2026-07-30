<?php

namespace App\Services;

use App\Models\KycRequest;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;

class KycService
{
    public function upload(UploadedFile $file, string $type, int $userId): string
    {
        $dir = sprintf('kyc/%d/%s', $userId, $type);
        $path = $file->store($dir, config('filesystems.default'));

        return Storage::disk(config('filesystems.default'))->url($path);
    }

    public function upsert(int $userId, array $payload): KycRequest
    {
        $existing = KycRequest::where('user_id', $userId)->latest('id')->first();

        if (!$existing) {
            return KycRequest::create(array_merge($payload, [
                'user_id' => $userId,
                'status' => 'pending',
            ]));
        }

        $existing->fill($payload);
        $existing->status = 'pending';
        $existing->save();

        return $existing;
    }
}
