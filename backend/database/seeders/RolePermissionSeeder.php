<?php

namespace Database\Seeders;

use App\Models\Permission;
use App\Models\Role;
use Illuminate\Database\Seeder;

class RolePermissionSeeder extends Seeder
{
    public function run(): void
    {
        $roles = [
            'super_admin' => 'Super Admin',
            'support_agent' => 'Support Agent',
            'auditor' => 'Auditor',
        ];

        $permissions = [
            'super_admin' => [
                'users.manage',
                'wallets.adjust',
                'transactions.view',
                'kyc.review',
                'settings.manage',
                'reports.view',
            ],
            'support_agent' => [
                'tickets.manage',
                'users.view',
                'transactions.view',
            ],
            'auditor' => [
                'reports.view',
                'audit_logs.view',
                'transactions.view',
            ],
        ];

        foreach ($roles as $key => $name) {
            $role = Role::updateOrCreate(
                ['name' => $key],
                [
                    'display_name' => $name,
                    'description' => $name.' role',
                    'created_at' => now(),
                ]
            );

            foreach ($permissions[$key] as $permissionKey) {
                Permission::updateOrCreate(
                    ['role_id' => $role->id, 'permission_key' => $permissionKey],
                    ['created_at' => now()]
                );
            }
        }
    }
}
