<?php

namespace App\Http\Requests\Support;

use Illuminate\Foundation\Http\FormRequest;

class CreateTicketRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'subject' => ['required', 'string', 'max:160'],
            'category' => ['nullable', 'string', 'max:60'],
            'priority' => ['nullable', 'in:low,medium,high,critical'],
        ];
    }
}
