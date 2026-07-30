import React, { useState } from 'react';
import { mockTransactions, type Transaction } from '../data/mockData';
import { Search, Download } from 'lucide-react';

const typeBadge = (type: Transaction['type']) => {
  const map: Record<string, string> = {
    credit: 'bg-green-50 text-green-700',
    debit: 'bg-red-50 text-red-700',
    transfer: 'bg-blue-50 text-blue-700',
    bill: 'bg-purple-50 text-purple-700',
    topup: 'bg-cyan-50 text-cyan-700',
    withdraw: 'bg-orange-50 text-orange-700',
  };
  return map[type] ?? 'bg-gray-100 text-gray-600';
};

const statusBadge = (status: Transaction['status']) => {
  const map = {
    success: 'bg-green-50 text-green-700',
    pending: 'bg-amber-50 text-amber-700',
    failed: 'bg-red-50 text-red-700',
  };
  return map[status];
};

const TransactionsPage: React.FC = () => {
  const [search, setSearch] = useState('');
  const [filterStatus, setFilterStatus] = useState('all');
  const [filterType, setFilterType] = useState('all');

  const filtered = mockTransactions.filter((t) => {
    const q = search.toLowerCase();
    const matchQ =
      t.userName.toLowerCase().includes(q) ||
      t.id.includes(q) ||
      t.description.toLowerCase().includes(q);
    const matchStatus = filterStatus === 'all' || t.status === filterStatus;
    const matchType = filterType === 'all' || t.type === filterType;
    return matchQ && matchStatus && matchType;
  });

  return (
    <div className="space-y-5">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-xl font-bold text-gray-900">Transactions</h1>
          <p className="text-sm text-gray-500">{filtered.length} transactions</p>
        </div>
        <button className="flex items-center gap-2 px-4 py-2 bg-green-600 text-white rounded-xl text-sm hover:bg-green-700 transition-colors">
          <Download size={16} />
          Export CSV
        </button>
      </div>

      {/* Filters */}
      <div className="flex flex-wrap gap-3">
        <div className="relative flex-1 min-w-52">
          <Search className="absolute left-3 top-2.5 text-gray-400" size={16} />
          <input
            type="text"
            placeholder="Search transactions..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="w-full pl-9 pr-4 py-2.5 border border-gray-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-green-500"
          />
        </div>
        <select
          value={filterStatus}
          onChange={(e) => setFilterStatus(e.target.value)}
          className="border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none"
        >
          <option value="all">All Status</option>
          <option value="success">Success</option>
          <option value="pending">Pending</option>
          <option value="failed">Failed</option>
        </select>
        <select
          value={filterType}
          onChange={(e) => setFilterType(e.target.value)}
          className="border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none"
        >
          <option value="all">All Types</option>
          <option value="transfer">Transfer</option>
          <option value="bill">Bill Pay</option>
          <option value="topup">Top-up</option>
          <option value="withdraw">Withdraw</option>
          <option value="credit">Credit</option>
        </select>
      </div>

      {/* Table */}
      <div className="bg-white rounded-2xl border border-gray-100 overflow-hidden">
        <table className="w-full text-sm">
          <thead>
            <tr className="text-left text-xs text-gray-400 border-b border-gray-100 bg-gray-50">
              {['ID', 'User', 'Type', 'Amount', 'Status', 'Description', 'Date'].map((h) => (
                <th key={h} className="px-4 py-3 font-medium">{h}</th>
              ))}
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-50">
            {filtered.map((tx) => (
              <tr key={tx.id} className="hover:bg-gray-50">
                <td className="px-4 py-3 text-gray-400 font-mono text-xs">{tx.id}</td>
                <td className="px-4 py-3 font-medium text-gray-800">{tx.userName}</td>
                <td className="px-4 py-3">
                  <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${typeBadge(tx.type)}`}>
                    {tx.type}
                  </span>
                </td>
                <td className="px-4 py-3 font-semibold">NPR {tx.amount.toLocaleString()}</td>
                <td className="px-4 py-3">
                  <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${statusBadge(tx.status)}`}>
                    {tx.status}
                  </span>
                </td>
                <td className="px-4 py-3 text-gray-500 max-w-xs truncate">{tx.description}</td>
                <td className="px-4 py-3 text-gray-400 text-xs">{tx.createdAt}</td>
              </tr>
            ))}
          </tbody>
        </table>
        {filtered.length === 0 && (
          <div className="text-center py-12 text-gray-400">No transactions found</div>
        )}
      </div>
    </div>
  );
};

export default TransactionsPage;
