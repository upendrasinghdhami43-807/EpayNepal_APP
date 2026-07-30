<?php

namespace App\Http\Requests\Auth;

use Illuminate\Foundation\Http\FormRequest;

class OtpRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'phone' => ['required', 'regex:/^(98|97)\d{8}$/'],
            'code' => ['nullable', 'digits:6'],
            'purpose' => ['required', 'in:register,login,reset_password,transaction'],
        ];
    }
}
