<?php

namespace App\Providers;

use App\Events\TransactionCompleted;
use App\Integrations\Email\EmailGatewayInterface;
use App\Integrations\Email\LaravelMailGateway;
use App\Integrations\Push\FcmPushGateway;
use App\Integrations\Push\PushGatewayInterface;
use App\Integrations\Sms\LogSmsGateway;
use App\Integrations\Sms\SmsGatewayInterface;
use App\Listeners\LogFinancialTransaction;
use App\Repositories\Contracts\NotificationRepositoryInterface;
use App\Repositories\Contracts\TransactionRepositoryInterface;
use App\Repositories\Contracts\WalletRepositoryInterface;
use App\Repositories\NotificationRepository;
use App\Repositories\TransactionRepository;
use App\Repositories\WalletRepository;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(WalletRepositoryInterface::class, WalletRepository::class);
        $this->app->bind(TransactionRepositoryInterface::class, TransactionRepository::class);
        $this->app->bind(NotificationRepositoryInterface::class, NotificationRepository::class);
        $this->app->bind(SmsGatewayInterface::class, LogSmsGateway::class);
        $this->app->bind(PushGatewayInterface::class, FcmPushGateway::class);
        $this->app->bind(EmailGatewayInterface::class, LaravelMailGateway::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Event::listen(TransactionCompleted::class, LogFinancialTransaction::class);
    }
}
