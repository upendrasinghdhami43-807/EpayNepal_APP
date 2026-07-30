<?php

namespace App\Http\Requests\User;

use Illuminate\Foundation\Http\FormRequest;

class RegisterDeviceRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'device_name' => ['required', 'string', 'max:100'],
            'device_id' => ['required', 'string', 'max:255'],
            'fcm_token' => ['nullable', 'string', 'max:500'],
            'platform' => ['required', 'in:android,ios'],
        ];
    }
}
