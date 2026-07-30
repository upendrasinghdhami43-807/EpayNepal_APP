<?php

namespace App\Services;

use App\Models\Transaction;
use App\Models\User;

class ReportService
{
    public function dashboard(): array
    {
        return [
            'total_users' => User::count(),
            'total_transactions' => Transaction::count(),
            'today_volume' => (float) Transaction::whereDate('created_at', now()->toDateString())->sum('amount'),
            'pending_transactions' => Transaction::where('status', 'pending')->count(),
        ];
    }
}
