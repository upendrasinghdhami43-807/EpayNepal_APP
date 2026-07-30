<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Wallet;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DemoUserSeeder extends Seeder
{
    public function run(): void
    {
        $user = User::updateOrCreate(
            ['phone' => '9800000001'],
            [
                'name' => 'Demo User',
                'email' => 'demo.user@epaynepal.com',
                'password' => Hash::make('User@12345'),
                'status' => 'active',
                'kyc_level' => 'basic',
            ]
        );

        Wallet::updateOrCreate(
            ['user_id' => $user->id],
            [
                'balance' => 10000,
                'currency' => 'NPR',
                'is_active' => true,
            ]
        );
    }
}
