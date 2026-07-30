<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MerchantQr extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $table = 'merchant_qr';

    protected $fillable = [
        'merchant_id',
        'qr_code',
        'qr_payload',
        'is_active',
        'created_at',
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];
}
