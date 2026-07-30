<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\User\RegisterDeviceRequest;
use App\Http\Requests\User\UpdateProfileRequest;
use App\Models\Device;
use App\Support\ApiResponse;

class UserController extends Controller
{
    use ApiResponse;

    public function show()
    {
        return $this->success(auth()->user());
    }

    public function update(UpdateProfileRequest $request)
    {
        $user = $request->user();
        $user->update($request->validated());

        return $this->success($user, 'Profile updated.');
    }

    public function registerDevice(RegisterDeviceRequest $request)
    {
        $data = $request->validated();

        $device = Device::updateOrCreate(
            ['device_id' => $data['device_id']],
            [
                'user_id' => $request->user()->id,
                'device_name' => $data['device_name'],
                'fcm_token' => $data['fcm_token'] ?? null,
                'platform' => $data['platform'],
                'is_active' => true,
                'last_active_at' => now(),
            ]
        );

        return $this->success($device, 'Device registered.');
    }
}
