import React from 'react';
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  AreaChart,
  Area,
} from 'recharts';

const userGrowth = [
  { month: 'Aug', users: 1200 },
  { month: 'Sep', users: 2100 },
  { month: 'Oct', users: 3400 },
  { month: 'Nov', users: 4800 },
  { month: 'Dec', users: 5900 },
  { month: 'Jan', users: 6842 },
];

const txVolume = [
  { month: 'Aug', volume: 800000 },
  { month: 'Sep', volume: 1200000 },
  { month: 'Oct', volume: 1900000 },
  { month: 'Nov', volume: 2600000 },
  { month: 'Dec', volume: 3400000 },
  { month: 'Jan', volume: 4100000 },
];

const ReportsPage: React.FC = () => {
  return (
    <div className="space-y-5">
      <div>
        <h1 className="text-xl font-bold text-gray-900">Reports & Analytics</h1>
        <p className="text-sm text-gray-500">Platform performance metrics</p>
      </div>

      <div className="grid xl:grid-cols-2 gap-4">
        {/* User Growth */}
        <div className="bg-white rounded-2xl border border-gray-100 p-5">
          <h2 className="text-sm font-semibold text-gray-700 mb-4">User Growth</h2>
          <ResponsiveContainer width="100%" height={220}>
            <AreaChart data={userGrowth}>
              <defs>
                <linearGradient id="userGrad" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="5%" stopColor="#16a34a" stopOpacity={0.15} />
                  <stop offset="95%" stopColor="#16a34a" stopOpacity={0} />
                </linearGradient>
              </defs>
              <CartesianGrid strokeDasharray="3 3" stroke="#f1f5f9" />
              <XAxis dataKey="month" tick={{ fontSize: 11 }} />
              <YAxis tick={{ fontSize: 11 }} tickFormatter={(v) => `${(v / 1000).toFixed(0)}k`} />
              <Tooltip formatter={(v: any) => [v.toLocaleString(), 'Users']} />
              <Area type="monotone" dataKey="users" stroke="#16a34a" fill="url(#userGrad)" strokeWidth={2} />
            </AreaChart>
          </ResponsiveContainer>
        </div>

        {/* Volume */}
        <div className="bg-white rounded-2xl border border-gray-100 p-5">
          <h2 className="text-sm font-semibold text-gray-700 mb-4">Monthly Volume (NPR)</h2>
          <ResponsiveContainer width="100%" height={220}>
            <BarChart data={txVolume}>
              <CartesianGrid strokeDasharray="3 3" stroke="#f1f5f9" />
              <XAxis dataKey="month" tick={{ fontSize: 11 }} />
              <YAxis tick={{ fontSize: 11 }} tickFormatter={(v) => `${(v / 1000000).toFixed(1)}M`} />
              <Tooltip formatter={(v: any) => [`NPR ${(v / 1000000).toFixed(2)}M`]} />
              <Bar dataKey="volume" fill="#2563eb" radius={[6, 6, 0, 0]} />
            </BarChart>
          </ResponsiveContainer>
        </div>
      </div>

      {/* Summary Table */}
      <div className="bg-white rounded-2xl border border-gray-100 p-5">
        <h2 className="text-sm font-semibold text-gray-700 mb-4">Monthly Summary</h2>
        <table className="w-full text-sm">
          <thead>
            <tr className="text-left text-xs text-gray-400 border-b border-gray-100">
              <th className="pb-2 font-medium">Month</th>
              <th className="pb-2 font-medium">New Users</th>
              <th className="pb-2 font-medium">Transactions</th>
              <th className="pb-2 font-medium">Volume (NPR)</th>
              <th className="pb-2 font-medium">Revenue (NPR)</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-50">
            {[
              { m: 'January 2025', users: 942, txns: 18450, vol: 4100000, rev: 41000 },
              { m: 'December 2024', users: 1100, txns: 15200, vol: 3400000, rev: 34000 },
              { m: 'November 2024', users: 1400, txns: 12800, vol: 2600000, rev: 26000 },
            ].map((row) => (
              <tr key={row.m} className="hover:bg-gray-50">
                <td className="py-2.5 font-medium">{row.m}</td>
                <td className="py-2.5 text-green-700 font-semibold">+{row.users.toLocaleString()}</td>
                <td className="py-2.5">{row.txns.toLocaleString()}</td>
                <td className="py-2.5">NPR {(row.vol / 1000000).toFixed(1)}M</td>
                <td className="py-2.5 text-blue-700 font-semibold">NPR {row.rev.toLocaleString()}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default ReportsPage;
