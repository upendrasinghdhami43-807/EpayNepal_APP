<?php

namespace App\Services;

use App\Models\AppSetting;

class SettingService
{
    public function all(): array
    {
        return AppSetting::query()->pluck('value', 'key')->toArray();
    }

    public function upsert(array $items): void
    {
        foreach ($items as $key => $value) {
            AppSetting::updateOrCreate(
                ['key' => $key],
                ['value' => is_scalar($value) ? (string) $value : json_encode($value)]
            );
        }
    }
}
