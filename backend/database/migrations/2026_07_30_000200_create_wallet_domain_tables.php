<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('roles', function (Blueprint $table) {
            $table->id();
            $table->string('name', 50)->unique();
            $table->string('display_name', 80);
            $table->string('description', 255)->nullable();
            $table->timestamp('created_at')->useCurrent();
        });

        Schema::create('admin_users', function (Blueprint $table) {
            $table->id();
            $table->string('name', 120);
            $table->string('email')->unique();
            $table->string('password_hash');
            $table->foreignId('role_id')->nullable()->constrained('roles')->nullOnDelete();
            $table->boolean('is_active')->default(true)->index();
            $table->timestamp('last_login_at')->nullable();
            $table->timestamps();
        });

        Schema::create('permissions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('role_id')->constrained('roles')->cascadeOnDelete();
            $table->string('permission_key', 100);
            $table->timestamp('created_at')->useCurrent();
            $table->unique(['role_id', 'permission_key']);
        });

        Schema::create('wallets', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->decimal('balance', 18, 2)->default(0);
            $table->string('currency', 3)->default('NPR');
            $table->boolean('is_active')->default(true)->index();
            $table->timestamps();
            $table->unique('user_id');
        });

        Schema::create('transactions', function (Blueprint $table) {
            $table->id();
            $table->string('reference_id', 64)->unique();
            $table->foreignId('sender_wallet_id')->nullable()->constrained('wallets')->nullOnDelete();
            $table->foreignId('receiver_wallet_id')->nullable()->constrained('wallets')->nullOnDelete();
            $table->string('type', 40);
            $table->decimal('amount', 18, 2);
            $table->decimal('fee', 18, 2)->default(0);
            $table->string('status', 20)->default('pending')->index();
            $table->string('description', 255)->nullable();
            $table->json('metadata')->nullable();
            $table->timestamps();
            $table->index(['sender_wallet_id', 'created_at']);
            $table->index(['receiver_wallet_id', 'created_at']);
        });

        Schema::create('transaction_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('transaction_id')->constrained('transactions')->cascadeOnDelete();
            $table->foreignId('wallet_id')->nullable()->constrained('wallets')->nullOnDelete();
            $table->string('action', 20);
            $table->decimal('amount', 18, 2);
            $table->decimal('balance_before', 18, 2)->default(0);
            $table->decimal('balance_after', 18, 2)->default(0);
            $table->timestamp('created_at')->useCurrent();
            $table->index(['wallet_id', 'created_at']);
        });

        Schema::create('beneficiaries', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('name', 120);
            $table->string('phone', 10)->nullable();
            $table->string('bank_account', 60)->nullable();
            $table->string('type', 20)->default('wallet');
            $table->timestamps();
            $table->index(['user_id', 'type']);
            $table->index(['user_id', 'phone']);
        });

        Schema::create('devices', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('device_name', 80);
            $table->string('device_id', 120)->unique();
            $table->string('fcm_token')->nullable();
            $table->string('platform', 20);
            $table->boolean('is_active')->default(true)->index();
            $table->timestamp('last_active_at')->nullable();
            $table->timestamps();
            $table->index('user_id');
        });

        Schema::create('notifications', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('title', 180);
            $table->text('body');
            $table->string('type', 40)->default('system');
            $table->json('data')->nullable();
            $table->boolean('is_read')->default(false)->index();
            $table->timestamp('read_at')->nullable();
            $table->timestamps();
            $table->index(['user_id', 'created_at']);
            $table->index(['user_id', 'is_read']);
        });

        Schema::create('otp_codes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();
            $table->string('phone', 10)->index();
            $table->string('code_hash');
            $table->string('purpose', 30);
            $table->unsignedSmallInteger('attempts')->default(0);
            $table->timestamp('expires_at')->index();
            $table->boolean('is_used')->default(false)->index();
            $table->timestamps();
            $table->index(['phone', 'purpose', 'is_used']);
        });

        Schema::create('kyc_requests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('citizenship_front_url')->nullable();
            $table->string('citizenship_back_url')->nullable();
            $table->string('selfie_url')->nullable();
            $table->string('full_name', 120);
            $table->string('citizenship_number', 40);
            $table->date('date_of_birth');
            $table->string('address_province', 80);
            $table->string('address_district', 80);
            $table->string('address_municipality', 120);
            $table->string('address_ward', 10);
            $table->string('status', 20)->default('pending')->index();
            $table->string('rejection_reason', 255)->nullable();
            $table->foreignId('reviewed_by')->nullable()->constrained('admin_users')->nullOnDelete();
            $table->timestamp('reviewed_at')->nullable();
            $table->timestamps();
            $table->index(['user_id', 'status']);
            $table->index('citizenship_number');
        });

        Schema::create('merchants', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('business_name', 160);
            $table->string('business_type', 80)->nullable();
            $table->string('pan_number', 60)->nullable();
            $table->string('address', 255)->nullable();
            $table->boolean('is_active')->default(true)->index();
            $table->timestamps();
            $table->unique('user_id');
            $table->index('pan_number');
        });

        Schema::create('merchant_qr', function (Blueprint $table) {
            $table->id();
            $table->foreignId('merchant_id')->constrained('merchants')->cascadeOnDelete();
            $table->string('qr_code', 120)->unique();
            $table->text('qr_payload');
            $table->boolean('is_active')->default(true)->index();
            $table->timestamp('created_at')->useCurrent();
            $table->index(['merchant_id', 'is_active']);
        });

        Schema::create('support_tickets', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('subject', 180);
            $table->string('category', 40)->default('general');
            $table->string('status', 20)->default('open')->index();
            $table->string('priority', 20)->default('medium')->index();
            $table->foreignId('assigned_to')->nullable()->constrained('admin_users')->nullOnDelete();
            $table->timestamps();
            $table->index(['user_id', 'created_at']);
        });

        Schema::create('support_messages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('ticket_id')->constrained('support_tickets')->cascadeOnDelete();
            $table->unsignedBigInteger('sender_id');
            $table->string('sender_type', 20);
            $table->text('message');
            $table->string('attachment_url')->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->index(['ticket_id', 'created_at']);
            $table->index(['sender_type', 'sender_id']);
        });

        Schema::create('audit_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('admin_user_id')->nullable()->constrained('admin_users')->nullOnDelete();
            $table->foreignId('user_id')->nullable()->constrained()->nullOnDelete();
            $table->string('action', 120);
            $table->string('entity_type', 80)->nullable();
            $table->unsignedBigInteger('entity_id')->nullable();
            $table->json('old_values')->nullable();
            $table->json('new_values')->nullable();
            $table->string('ip_address', 45)->nullable();
            $table->timestamp('created_at')->useCurrent();
            $table->index(['admin_user_id', 'created_at']);
            $table->index(['user_id', 'created_at']);
            $table->index(['entity_type', 'entity_id']);
        });

        Schema::create('app_settings', function (Blueprint $table) {
            $table->id();
            $table->string('key', 120)->unique();
            $table->text('value')->nullable();
            $table->string('description', 255)->nullable();
            $table->timestamp('updated_at')->nullable();
        });

        Schema::create('payment_requests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('requester_id')->constrained('users')->cascadeOnDelete();
            $table->foreignId('receiver_id')->constrained('users')->cascadeOnDelete();
            $table->decimal('amount', 18, 2);
            $table->string('status', 20)->default('pending')->index();
            $table->string('note', 255)->nullable();
            $table->timestamp('expires_at')->nullable();
            $table->timestamps();
            $table->index(['requester_id', 'status']);
            $table->index(['receiver_id', 'status']);
        });

        Schema::create('recharge_history', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('transaction_id')->nullable()->constrained('transactions')->nullOnDelete();
            $table->string('phone', 10);
            $table->string('operator', 60)->nullable();
            $table->decimal('amount', 18, 2);
            $table->string('status', 20)->default('completed')->index();
            $table->json('metadata')->nullable();
            $table->timestamps();
            $table->index(['user_id', 'created_at']);
            $table->index('phone');
        });

        Schema::create('bill_payments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('transaction_id')->nullable()->constrained('transactions')->nullOnDelete();
            $table->string('bill_type', 40);
            $table->string('provider', 80)->nullable();
            $table->string('consumer_number', 60);
            $table->decimal('amount', 18, 2);
            $table->string('status', 20)->default('completed')->index();
            $table->json('metadata')->nullable();
            $table->timestamps();
            $table->index(['user_id', 'created_at']);
            $table->index(['bill_type', 'status']);
        });

        if (Schema::getConnection()->getDriverName() === 'pgsql') {
            DB::statement("ALTER TABLE wallets ADD CONSTRAINT wallets_balance_non_negative CHECK (balance >= 0)");
            DB::statement("ALTER TABLE transactions ADD CONSTRAINT transactions_amount_positive CHECK (amount > 0)");
            DB::statement("ALTER TABLE transactions ADD CONSTRAINT transactions_fee_non_negative CHECK (fee >= 0)");
            DB::statement("ALTER TABLE transaction_logs ADD CONSTRAINT transaction_logs_amount_non_negative CHECK (amount >= 0)");
            DB::statement("ALTER TABLE payment_requests ADD CONSTRAINT payment_requests_amount_positive CHECK (amount > 0)");
            DB::statement("ALTER TABLE recharge_history ADD CONSTRAINT recharge_history_amount_positive CHECK (amount > 0)");
            DB::statement("ALTER TABLE bill_payments ADD CONSTRAINT bill_payments_amount_positive CHECK (amount > 0)");
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('bill_payments');
        Schema::dropIfExists('recharge_history');
        Schema::dropIfExists('payment_requests');
        Schema::dropIfExists('app_settings');
        Schema::dropIfExists('audit_logs');
        Schema::dropIfExists('support_messages');
        Schema::dropIfExists('support_tickets');
        Schema::dropIfExists('merchant_qr');
        Schema::dropIfExists('merchants');
        Schema::dropIfExists('kyc_requests');
        Schema::dropIfExists('otp_codes');
        Schema::dropIfExists('notifications');
        Schema::dropIfExists('devices');
        Schema::dropIfExists('beneficiaries');
        Schema::dropIfExists('transaction_logs');
        Schema::dropIfExists('transactions');
        Schema::dropIfExists('wallets');
        Schema::dropIfExists('permissions');
        Schema::dropIfExists('admin_users');
        Schema::dropIfExists('roles');
    }
};
