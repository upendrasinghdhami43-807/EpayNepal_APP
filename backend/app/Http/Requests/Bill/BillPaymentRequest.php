<?php

namespace App\Http\Requests\Bill;

use Illuminate\Foundation\Http\FormRequest;

class BillPaymentRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'amount' => ['required', 'numeric', 'min:1'],
            'consumer_number' => ['required', 'string', 'max:60'],
            'provider' => ['nullable', 'string', 'max:80'],
            'transaction_pin' => ['required', 'digits:4'],
        ];
    }
}
