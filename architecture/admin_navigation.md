# EpayNepal — Admin Dashboard Navigation

## Layout Structure

```
┌──────────────────────────────────────────────────┐
│ Top Bar (logo, search, notifications, profile)    │
├──────────┬───────────────────────────────────────┤
│          │                                       │
│ Sidebar  │          Main Content Area            │
│          │                                       │
│ Dashboard│                                       │
│ Users    │                                       │
│ Wallets  │                                       │
│ Trans.   │                                       │
│ KYC      │                                       │
│ Merchants│                                       │
│ Support  │                                       │
│ Notif.   │                                       │
│ Reports  │                                       │
│ Audit    │                                       │
│ Settings │                                       │
│          │                                       │
└──────────┴───────────────────────────────────────┘
```

## Routes

| Path | Page | Sidebar Item |
|------|------|-------------|
| `/login` | Admin Login | (no sidebar) |
| `/` | Dashboard | Dashboard |
| `/users` | User List | Users |
| `/users/:id` | User Detail | Users |
| `/wallets` | Wallet Management | Wallets |
| `/wallets/:userId` | User Wallet Detail | Wallets |
| `/transactions` | Transaction List | Transactions |
| `/transactions/:id` | Transaction Detail | Transactions |
| `/kyc` | KYC Review Queue | KYC |
| `/kyc/:id` | KYC Detail | KYC |
| `/merchants` | Merchant List | Merchants |
| `/merchants/:id` | Merchant Detail | Merchants |
| `/support` | Support Tickets | Support |
| `/support/:id` | Ticket Detail | Support |
| `/notifications` | Notification Center | Notifications |
| `/reports` | Reports & Analytics | Reports |
| `/audit-logs` | Audit Logs | Audit Logs |
| `/roles` | Roles & Permissions | Settings |
| `/settings` | App Configuration | Settings |

## Role-Based Access

| Sidebar Item | Super Admin | Admin | KYC Officer | Support |
|-------------|:-----------:|:-----:|:-----------:|:-------:|
| Dashboard | ✅ | ✅ | ✅ | ✅ |
| Users | ✅ | ✅ | 👁️ | 👁️ |
| Wallets | ✅ | ✅ | ❌ | ❌ |
| Transactions | ✅ | ✅ | ❌ | 👁️ |
| KYC | ✅ | ✅ | ✅ | ❌ |
| Merchants | ✅ | ✅ | ❌ | ❌ |
| Support | ✅ | ✅ | ❌ | ✅ |
| Notifications | ✅ | ✅ | ❌ | ❌ |
| Reports | ✅ | ✅ | ❌ | ❌ |
| Audit Logs | ✅ | 👁️ | ❌ | ❌ |
| Settings | ✅ | ❌ | ❌ | ❌ |

✅ = Full access | 👁️ = Read only | ❌ = Hidden

## React Router Config

```tsx
<Routes>
  <Route path="/login" element={<LoginPage />} />
  <Route element={<AdminLayout />}>
    <Route index element={<DashboardPage />} />
    <Route path="users" element={<UserListPage />} />
    <Route path="users/:id" element={<UserDetailPage />} />
    <Route path="wallets" element={<WalletListPage />} />
    <Route path="transactions" element={<TransactionListPage />} />
    <Route path="transactions/:id" element={<TransactionDetailPage />} />
    <Route path="kyc" element={<KycQueuePage />} />
    <Route path="kyc/:id" element={<KycDetailPage />} />
    <Route path="merchants" element={<MerchantListPage />} />
    <Route path="support" element={<SupportListPage />} />
    <Route path="support/:id" element={<TicketDetailPage />} />
    <Route path="notifications" element={<NotificationPage />} />
    <Route path="reports" element={<ReportsPage />} />
    <Route path="audit-logs" element={<AuditLogPage />} />
    <Route path="roles" element={<RolesPage />} />
    <Route path="settings" element={<SettingsPage />} />
  </Route>
</Routes>
```
