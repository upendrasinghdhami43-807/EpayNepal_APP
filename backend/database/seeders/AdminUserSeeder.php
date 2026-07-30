<?php

namespace Database\Seeders;

use App\Models\AdminUser;
use App\Models\Role;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class AdminUserSeeder extends Seeder
{
    public function run(): void
    {
        $role = Role::where('name', 'super_admin')->first();

        AdminUser::updateOrCreate(
            ['email' => env('ADMIN_EMAIL', 'admin@epaynepal.com')],
            [
                'name' => env('ADMIN_NAME', 'EpayNepal Admin'),
                'password_hash' => Hash::make(env('ADMIN_PASSWORD', 'Admin@12345')),
                'role_id' => $role?->id,
                'is_active' => true,
            ]
        );
    }
}
