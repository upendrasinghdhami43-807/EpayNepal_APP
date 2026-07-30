// Mock data for admin panel

export interface User {
  id: string;
  name: string;
  phone: string;
  email: string;
  kycStatus: 'verified' | 'pending' | 'rejected' | 'not_started';
  status: 'active' | 'frozen' | 'suspended';
  balance: number;
  joinedAt: string;
  lastActive: string;
}

export interface Transaction {
  id: string;
  userId: string;
  userName: string;
  type: 'credit' | 'debit' | 'transfer' | 'bill' | 'topup' | 'withdraw';
  amount: number;
  status: 'success' | 'pending' | 'failed';
  description: string;
  createdAt: string;
}

export interface KycRequest {
  id: string;
  userId: string;
  userName: string;
  phone: string;
  submittedAt: string;
  status: 'pending' | 'approved' | 'rejected';
}

export const mockUsers: User[] = [
  { id: 'u1', name: 'Upendra Dhami', phone: '9841234567', email: 'upendra@example.com', kycStatus: 'verified', status: 'active', balance: 45280.5, joinedAt: '2024-01-15', lastActive: '2025-01-10' },
  { id: 'u2', name: 'Sita Sharma', phone: '9812345678', email: 'sita@example.com', kycStatus: 'verified', status: 'active', balance: 12450.0, joinedAt: '2024-02-20', lastActive: '2025-01-09' },
  { id: 'u3', name: 'Ram Bahadur', phone: '9861234567', email: 'ram@example.com', kycStatus: 'pending', status: 'active', balance: 3200.0, joinedAt: '2024-03-05', lastActive: '2025-01-08' },
  { id: 'u4', name: 'Gita Khadka', phone: '9851234567', email: 'gita@example.com', kycStatus: 'rejected', status: 'active', balance: 800.0, joinedAt: '2024-04-10', lastActive: '2025-01-07' },
  { id: 'u5', name: 'Birendra KC', phone: '9825678901', email: 'birendra@example.com', kycStatus: 'not_started', status: 'frozen', balance: 0, joinedAt: '2024-05-01', lastActive: '2025-01-01' },
  { id: 'u6', name: 'Kamala Thapa', phone: '9876543210', email: 'kamala@example.com', kycStatus: 'verified', status: 'active', balance: 28900.0, joinedAt: '2024-06-15', lastActive: '2025-01-10' },
];

export const mockTransactions: Transaction[] = [
  { id: 't1', userId: 'u1', userName: 'Upendra Dhami', type: 'credit', amount: 5000, status: 'success', description: 'Wallet Top-up via eSewa', createdAt: '2025-01-10 09:30' },
  { id: 't2', userId: 'u1', userName: 'Upendra Dhami', type: 'transfer', amount: 2000, status: 'success', description: 'Send to Sita Sharma', createdAt: '2025-01-10 10:15' },
  { id: 't3', userId: 'u2', userName: 'Sita Sharma', type: 'bill', amount: 600, status: 'success', description: 'Dish Home TV Bill', createdAt: '2025-01-09 14:00' },
  { id: 't4', userId: 'u3', userName: 'Ram Bahadur', type: 'topup', amount: 100, status: 'success', description: 'NTC Mobile Recharge', createdAt: '2025-01-09 11:30' },
  { id: 't5', userId: 'u4', userName: 'Gita Khadka', type: 'withdraw', amount: 3000, status: 'failed', description: 'Bank Withdrawal - Insufficient balance', createdAt: '2025-01-08 16:45' },
  { id: 't6', userId: 'u6', userName: 'Kamala Thapa', type: 'bill', amount: 1200, status: 'pending', description: 'Electricity Bill - NEA', createdAt: '2025-01-08 08:20' },
];

export const mockKycRequests: KycRequest[] = [
  { id: 'k1', userId: 'u3', userName: 'Ram Bahadur', phone: '9861234567', submittedAt: '2025-01-08', status: 'pending' },
  { id: 'k2', userId: 'u7', userName: 'Deepak Malla', phone: '9811111111', submittedAt: '2025-01-07', status: 'pending' },
  { id: 'k3', userId: 'u8', userName: 'Priya Pant', phone: '9822222222', submittedAt: '2025-01-06', status: 'approved' },
  { id: 'k4', userId: 'u4', userName: 'Gita Khadka', phone: '9851234567', submittedAt: '2025-01-05', status: 'rejected' },
];
