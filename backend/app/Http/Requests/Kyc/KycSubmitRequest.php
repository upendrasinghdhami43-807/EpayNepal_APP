<?php

namespace App\Http\Requests\Kyc;

use Illuminate\Foundation\Http\FormRequest;

class KycSubmitRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'full_name' => ['required', 'string', 'max:120'],
            'citizenship_number' => ['required', 'string', 'max:40'],
            'date_of_birth' => ['required', 'date'],
            'address_province' => ['required', 'string', 'max:80'],
            'address_district' => ['required', 'string', 'max:80'],
            'address_municipality' => ['required', 'string', 'max:120'],
            'address_ward' => ['required', 'string', 'max:10'],
        ];
    }
}
