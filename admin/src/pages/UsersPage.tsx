import React, { useState } from 'react';
import { mockUsers, User } from '../data/mockData';
import { Search, Filter, Snowflake, CheckCircle2, XCircle } from 'lucide-react';

const kycBadge = (status: User['kycStatus']) => {
  const map = {
    verified: 'bg-green-50 text-green-700',
    pending: 'bg-amber-50 text-amber-700',
    rejected: 'bg-red-50 text-red-700',
    not_started: 'bg-gray-100 text-gray-500',
  };
  return map[status];
};

const statusBadge = (status: User['status']) => {
  const map = {
    active: 'bg-green-50 text-green-700',
    frozen: 'bg-blue-50 text-blue-700',
    suspended: 'bg-red-50 text-red-700',
  };
  return map[status];
};

const UsersPage: React.FC = () => {
  const [search, setSearch] = useState('');
  const [users, setUsers] = useState(mockUsers);
  const [filterKyc, setFilterKyc] = useState('all');

  const filtered = users.filter((u) => {
    const q = search.toLowerCase();
    const matchQ =
      u.name.toLowerCase().includes(q) ||
      u.phone.includes(q) ||
      u.email.toLowerCase().includes(q);
    const matchKyc = filterKyc === 'all' || u.kycStatus === filterKyc;
    return matchQ && matchKyc;
  });

  const toggleFreeze = (id: string) => {
    setUsers((prev) =>
      prev.map((u) =>
        u.id === id
          ? { ...u, status: u.status === 'frozen' ? 'active' : 'frozen' }
          : u
      )
    );
  };

  return (
    <div className="space-y-5">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-xl font-bold text-gray-900">Users</h1>
          <p className="text-sm text-gray-500">{filtered.length} users found</p>
        </div>
      </div>

      {/* Filters */}
      <div className="flex flex-wrap gap-3">
        <div className="relative flex-1 min-w-52">
          <Search className="absolute left-3 top-2.5 text-gray-400" size={16} />
          <input
            type="text"
            placeholder="Search by name, phone, email..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="w-full pl-9 pr-4 py-2.5 border border-gray-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-green-500"
          />
        </div>
        <select
          value={filterKyc}
          onChange={(e) => setFilterKyc(e.target.value)}
          className="border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-500"
        >
          <option value="all">All KYC</option>
          <option value="verified">Verified</option>
          <option value="pending">Pending</option>
          <option value="rejected">Rejected</option>
          <option value="not_started">Not Started</option>
        </select>
      </div>

      {/* Table */}
      <div className="bg-white rounded-2xl border border-gray-100 overflow-hidden">
        <table className="w-full text-sm">
          <thead>
            <tr className="text-left text-xs text-gray-400 border-b border-gray-100 bg-gray-50">
              {['Name', 'Phone', 'Balance', 'KYC', 'Status', 'Joined', 'Actions'].map((h) => (
                <th key={h} className="px-4 py-3 font-medium">{h}</th>
              ))}
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-50">
            {filtered.map((user) => (
              <tr key={user.id} className="hover:bg-gray-50">
                <td className="px-4 py-3">
                  <div className="font-medium text-gray-800">{user.name}</div>
                  <div className="text-xs text-gray-400">{user.email}</div>
                </td>
                <td className="px-4 py-3 text-gray-500">{user.phone}</td>
                <td className="px-4 py-3 font-semibold">
                  NPR {user.balance.toLocaleString()}
                </td>
                <td className="px-4 py-3">
                  <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${kycBadge(user.kycStatus)}`}>
                    {user.kycStatus.replace('_', ' ')}
                  </span>
                </td>
                <td className="px-4 py-3">
                  <span className={`px-2 py-0.5 rounded-full text-xs font-medium ${statusBadge(user.status)}`}>
                    {user.status}
                  </span>
                </td>
                <td className="px-4 py-3 text-gray-400 text-xs">{user.joinedAt}</td>
                <td className="px-4 py-3">
                  <button
                    onClick={() => toggleFreeze(user.id)}
                    title={user.status === 'frozen' ? 'Unfreeze' : 'Freeze'}
                    className={`p-1.5 rounded-lg transition-colors ${
                      user.status === 'frozen'
                        ? 'bg-green-50 text-green-700 hover:bg-green-100'
                        : 'bg-blue-50 text-blue-700 hover:bg-blue-100'
                    }`}
                  >
                    {user.status === 'frozen' ? <CheckCircle2 size={16} /> : <Snowflake size={16} />}
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {filtered.length === 0 && (
          <div className="text-center py-12 text-gray-400">No users match your search</div>
        )}
      </div>
    </div>
  );
};

export default UsersPage;
