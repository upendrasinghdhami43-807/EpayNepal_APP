import React, { useState } from 'react';
import { Save } from 'lucide-react';

const SettingsPage: React.FC = () => {
  const [txFee, setTxFee] = useState('1.0');
  const [minWithdraw, setMinWithdraw] = useState('500');
  const [maxDailyLimit, setMaxDailyLimit] = useState('100000');
  const [kycLimit, setKycLimit] = useState('50000');
  const [saved, setSaved] = useState(false);

  const handleSave = (e: React.FormEvent) => {
    e.preventDefault();
    setSaved(true);
    setTimeout(() => setSaved(false), 2000);
  };

  return (
    <div className="space-y-5">
      <div>
        <h1 className="text-xl font-bold text-gray-900">Settings</h1>
        <p className="text-sm text-gray-500">Platform configuration</p>
      </div>

      {saved && (
        <div className="p-3 bg-green-50 border border-green-200 rounded-xl text-sm text-green-700">
          ✓ Settings saved successfully!
        </div>
      )}

      <form onSubmit={handleSave} className="space-y-4">
        {/* Fee Rules */}
        <div className="bg-white rounded-2xl border border-gray-100 p-5">
          <h2 className="text-sm font-semibold text-gray-700 mb-4">Fee Rules</h2>
          <div className="grid sm:grid-cols-2 gap-4">
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">Transaction Fee (%)</label>
              <input
                type="number"
                value={txFee}
                onChange={(e) => setTxFee(e.target.value)}
                step="0.1"
                min="0"
                max="10"
                className="w-full border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-500"
              />
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">Min Withdrawal (NPR)</label>
              <input
                type="number"
                value={minWithdraw}
                onChange={(e) => setMinWithdraw(e.target.value)}
                min="0"
                className="w-full border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-500"
              />
            </div>
          </div>
        </div>

        {/* Transaction Limits */}
        <div className="bg-white rounded-2xl border border-gray-100 p-5">
          <h2 className="text-sm font-semibold text-gray-700 mb-4">Transaction Limits</h2>
          <div className="grid sm:grid-cols-2 gap-4">
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">Max Daily Limit (NPR) — Unverified</label>
              <input
                type="number"
                value={maxDailyLimit}
                onChange={(e) => setMaxDailyLimit(e.target.value)}
                min="0"
                className="w-full border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-500"
              />
            </div>
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-1">Max Daily Limit (NPR) — KYC Verified</label>
              <input
                type="number"
                value={kycLimit}
                onChange={(e) => setKycLimit(e.target.value)}
                min="0"
                className="w-full border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-500"
              />
            </div>
          </div>
        </div>

        {/* App Info */}
        <div className="bg-white rounded-2xl border border-gray-100 p-5">
          <h2 className="text-sm font-semibold text-gray-700 mb-4">App Configuration</h2>
          <div className="space-y-3">
            {[
              { label: 'App Name', value: 'EpayNepal' },
              { label: 'Support Email', value: 'support@epaynepal.com' },
              { label: 'Support Phone', value: '01-4XXXXXX' },
            ].map((row) => (
              <div key={row.label}>
                <label className="block text-xs font-medium text-gray-600 mb-1">{row.label}</label>
                <input
                  defaultValue={row.value}
                  className="w-full border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-500"
                />
              </div>
            ))}
          </div>
        </div>

        <button
          type="submit"
          className="flex items-center gap-2 px-5 py-2.5 bg-green-600 text-white rounded-xl text-sm font-medium hover:bg-green-700 transition-colors"
        >
          <Save size={16} />
          Save Settings
        </button>
      </form>
    </div>
  );
};

export default SettingsPage;
