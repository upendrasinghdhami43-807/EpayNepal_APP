import React from 'react';
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  PieChart,
  Pie,
  Cell,
} from 'recharts';
import { Users, BadgeCheck, AlertTriangle, TrendingUp } from 'lucide-react';

const dailyVolume = [
  { date: 'Jan 4', amount: 120000 },
  { date: 'Jan 5', amount: 95000 },
  { date: 'Jan 6', amount: 145000 },
  { date: 'Jan 7', amount: 110000 },
  { date: 'Jan 8', amount: 170000 },
  { date: 'Jan 9', amount: 155000 },
  { date: 'Jan 10', amount: 192000 },
];

const txTypeData = [
  { name: 'Transfer', value: 38 },
  { name: 'Bill Pay', value: 25 },
  { name: 'Top-up', value: 20 },
  { name: 'Withdraw', value: 17 },
];

const COLORS = ['#16a34a', '#2563eb', '#f59e0b', '#dc2626'];

const StatCard: React.FC<{
  title: string;
  value: string;
  sub: string;
  icon: React.ReactNode;
  color: string;
}> = ({ title, value, sub, icon, color }) => (
  <div className="bg-white rounded-2xl p-5 border border-gray-100 flex items-start gap-4">
    <div className={`w-12 h-12 rounded-xl flex items-center justify-center ${color} shrink-0`}>
      {icon}
    </div>
    <div>
      <p className="text-sm text-gray-500">{title}</p>
      <p className="text-2xl font-bold text-gray-900 mt-0.5">{value}</p>
      <p className="text-xs text-gray-400 mt-0.5">{sub}</p>
    </div>
  </div>
);

const DashboardPage: React.FC = () => {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-xl font-bold text-gray-900">Dashboard</h1>
        <p className="text-sm text-gray-500">Overview of EpayNepal platform</p>
      </div>

      {/* KPI Cards */}
      <div className="grid grid-cols-2 xl:grid-cols-4 gap-4">
        <StatCard
          title="Total Users"
          value="6,842"
          sub="+124 this week"
          icon={<Users size={22} className="text-green-700" />}
          color="bg-green-50"
        />
        <StatCard
          title="Total Volume (Today)"
          value="NPR 1.92L"
          sub="7-day avg: NPR 1.41L"
          icon={<TrendingUp size={22} className="text-blue-700" />}
          color="bg-blue-50"
        />
        <StatCard
          title="KYC Pending"
          value="28"
          sub="Needs review"
          icon={<BadgeCheck size={22} className="text-amber-700" />}
          color="bg-amber-50"
        />
        <StatCard
          title="Flagged Transactions"
          value="4"
          sub="Suspicious activity"
          icon={<AlertTriangle size={22} className="text-red-700" />}
          color="bg-red-50"
        />
      </div>

      {/* Charts row */}
      <div className="grid grid-cols-1 xl:grid-cols-3 gap-4">
        {/* Daily Volume */}
        <div className="xl:col-span-2 bg-white rounded-2xl p-5 border border-gray-100">
          <h2 className="text-sm font-semibold text-gray-700 mb-4">Daily Transaction Volume (NPR)</h2>
          <ResponsiveContainer width="100%" height={220}>
            <LineChart data={dailyVolume}>
              <CartesianGrid strokeDasharray="3 3" stroke="#f1f5f9" />
              <XAxis dataKey="date" tick={{ fontSize: 11 }} />
              <YAxis tick={{ fontSize: 11 }} tickFormatter={(v) => `${(v / 1000).toFixed(0)}k`} />
              <Tooltip formatter={(v: any) => [`NPR ${v.toLocaleString()}`, 'Volume']} />
              <Line type="monotone" dataKey="amount" stroke="#16a34a" strokeWidth={2} dot={{ r: 3 }} />
            </LineChart>
          </ResponsiveContainer>
        </div>

        {/* Transaction types */}
        <div className="bg-white rounded-2xl p-5 border border-gray-100">
          <h2 className="text-sm font-semibold text-gray-700 mb-4">Transaction Types</h2>
          <ResponsiveContainer width="100%" height={160}>
            <PieChart>
              <Pie data={txTypeData} innerRadius={50} outerRadius={70} dataKey="value" paddingAngle={3}>
                {txTypeData.map((_, i) => (
                  <Cell key={i} fill={COLORS[i % COLORS.length]} />
                ))}
              </Pie>
              <Tooltip formatter={(v: any) => [`${v}%`]} />
            </PieChart>
          </ResponsiveContainer>
          <div className="grid grid-cols-2 gap-1 mt-2">
            {txTypeData.map((item, i) => (
              <div key={item.name} className="flex items-center gap-1.5">
                <div className="w-2.5 h-2.5 rounded-full shrink-0" style={{ background: COLORS[i] }} />
                <span className="text-xs text-gray-500">{item.name} {item.value}%</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Recent activity */}
      <div className="bg-white rounded-2xl p-5 border border-gray-100">
        <h2 className="text-sm font-semibold text-gray-700 mb-4">Recent Transactions</h2>
        <table className="w-full text-sm">
          <thead>
            <tr className="text-left text-xs text-gray-400 border-b border-gray-100">
              <th className="pb-2 font-medium">User</th>
              <th className="pb-2 font-medium">Type</th>
              <th className="pb-2 font-medium">Amount</th>
              <th className="pb-2 font-medium">Status</th>
              <th className="pb-2 font-medium">Time</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-50">
            {[
              { user: 'Upendra Dhami', type: 'Top-up', amount: 5000, status: 'success', time: '09:30' },
              { user: 'Sita Sharma', type: 'TV Bill', amount: 600, status: 'success', time: '14:00' },
              { user: 'Gita Khadka', type: 'Withdraw', amount: 3000, status: 'failed', time: '16:45' },
              { user: 'Kamala Thapa', type: 'Electricity', amount: 1200, status: 'pending', time: '08:20' },
            ].map((row, i) => (
              <tr key={i} className="hover:bg-gray-50">
                <td className="py-2.5 font-medium text-gray-700">{row.user}</td>
                <td className="py-2.5 text-gray-500">{row.type}</td>
                <td className="py-2.5 font-semibold">NPR {row.amount.toLocaleString()}</td>
                <td className="py-2.5">
                  <span
                    className={`px-2 py-0.5 rounded-full text-xs font-medium ${
                      row.status === 'success'
                        ? 'bg-green-50 text-green-700'
                        : row.status === 'failed'
                        ? 'bg-red-50 text-red-700'
                        : 'bg-amber-50 text-amber-700'
                    }`}
                  >
                    {row.status}
                  </span>
                </td>
                <td className="py-2.5 text-gray-400">Jan 10, {row.time}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default DashboardPage;
