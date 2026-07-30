<?php

namespace App\Http\Requests\Qr;

use Illuminate\Foundation\Http\FormRequest;

class QrPayRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'qr_payload' => ['required', 'string', 'max:1000'],
            'amount' => ['required', 'numeric', 'min:1'],
            'description' => ['nullable', 'string', 'max:255'],
            'transaction_pin' => ['required', 'digits:4'],
        ];
    }
}
