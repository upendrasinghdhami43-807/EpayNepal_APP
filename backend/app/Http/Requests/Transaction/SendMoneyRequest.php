<?php

namespace App\Http\Requests\Transaction;

use Illuminate\Foundation\Http\FormRequest;

class SendMoneyRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'recipient_phone' => ['required', 'regex:/^(98|97)\d{8}$/'],
            'amount' => ['required', 'numeric', 'min:1', 'max:1000000'],
            'description' => ['nullable', 'string', 'max:255'],
            'transaction_pin' => ['required', 'digits:4'],
        ];
    }
}
