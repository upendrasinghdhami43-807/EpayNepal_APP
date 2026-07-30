<?php

namespace Database\Seeders;

use App\Models\AppSetting;
use Illuminate\Database\Seeder;

class AppSettingSeeder extends Seeder
{
    public function run(): void
    {
        $settings = [
            'app.maintenance_mode' => 'false',
            'wallet.daily_transfer_limit' => '200000',
            'wallet.min_topup_amount' => '10',
            'kyc.required_for_p2p' => 'true',
            'notification.push_enabled' => 'true',
        ];

        foreach ($settings as $key => $value) {
            AppSetting::updateOrCreate(
                ['key' => $key],
                [
                    'value' => $value,
                    'description' => 'Seeded default setting',
                    'updated_at' => now(),
                ]
            );
        }
    }
}
