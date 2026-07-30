import React from 'react';
import { Store, Plus } from 'lucide-react';

const merchants = [
  { id: 'm1', name: 'Bhatbhateni Superstore', category: 'Retail', status: 'active', txns: 1240, volume: 892000 },
  { id: 'm2', name: 'Pathao Nepal', category: 'Transport', status: 'active', txns: 3800, volume: 1200000 },
  { id: 'm3', name: 'Foodmandu', category: 'Food & Delivery', status: 'active', txns: 920, volume: 450000 },
  { id: 'm4', name: 'Daraz Nepal', category: 'E-commerce', status: 'active', txns: 5600, volume: 3200000 },
  { id: 'm5', name: 'Tootle Ride', category: 'Transport', status: 'inactive', txns: 0, volume: 0 },
];

const MerchantsPage: React.FC = () => {
  return (
    <div className="space-y-5">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-xl font-bold text-gray-900">Merchants</h1>
          <p className="text-sm text-gray-500">{merchants.length} registered merchants</p>
        </div>
        <button className="flex items-center gap-2 px-4 py-2 bg-green-600 text-white rounded-xl text-sm hover:bg-green-700 transition-colors">
          <Plus size={16} />
          Add Merchant
        </button>
      </div>

      <div className="grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
        {merchants.map((m) => (
          <div key={m.id} className="bg-white rounded-2xl border border-gray-100 p-5 space-y-3">
            <div className="flex items-center gap-3">
              <div className="w-10 h-10 bg-blue-50 rounded-xl flex items-center justify-center">
                <Store size={20} className="text-blue-600" />
              </div>
              <div>
                <h3 className="font-semibold text-gray-900 text-sm">{m.name}</h3>
                <span className="text-xs text-gray-400">{m.category}</span>
              </div>
              <span
                className={`ml-auto px-2 py-0.5 rounded-full text-xs font-medium ${
                  m.status === 'active'
                    ? 'bg-green-50 text-green-700'
                    : 'bg-gray-100 text-gray-500'
                }`}
              >
                {m.status}
              </span>
            </div>
            <div className="grid grid-cols-2 gap-2 text-center">
              <div className="bg-gray-50 rounded-xl p-3">
                <p className="text-lg font-bold text-gray-800">{m.txns.toLocaleString()}</p>
                <p className="text-xs text-gray-400">Transactions</p>
              </div>
              <div className="bg-gray-50 rounded-xl p-3">
                <p className="text-lg font-bold text-gray-800">
                  {m.volume >= 1000000
                    ? `${(m.volume / 1000000).toFixed(1)}M`
                    : m.volume >= 1000
                    ? `${(m.volume / 1000).toFixed(0)}K`
                    : m.volume}
                </p>
                <p className="text-xs text-gray-400">Volume (NPR)</p>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default MerchantsPage;
