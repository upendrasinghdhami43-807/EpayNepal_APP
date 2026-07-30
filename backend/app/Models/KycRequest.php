<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class KycRequest extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'citizenship_front_url',
        'citizenship_back_url',
        'selfie_url',
        'full_name',
        'citizenship_number',
        'date_of_birth',
        'address_province',
        'address_district',
        'address_municipality',
        'address_ward',
        'status',
        'rejection_reason',
        'reviewed_by',
        'reviewed_at',
    ];

    protected $casts = [
        'date_of_birth' => 'date',
        'reviewed_at' => 'datetime',
    ];
}
