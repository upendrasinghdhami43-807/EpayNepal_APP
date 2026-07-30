import React, { useState } from 'react';
import { mockKycRequests, type KycRequest } from '../data/mockData';
import { Check, X } from 'lucide-react';

const KycPage: React.FC = () => {
  const [requests, setRequests] = useState(mockKycRequests);
  const [filter, setFilter] = useState<'all' | 'pending' | 'approved' | 'rejected'>('pending');

  const filtered = requests.filter((r) => filter === 'all' || r.status === filter);

  const updateStatus = (id: string, status: KycRequest['status']) => {
    setRequests((prev) =>
      prev.map((r) => (r.id === id ? { ...r, status } : r))
    );
  };

  const badgeClass = (status: KycRequest['status']) => {
    const map = {
      pending: 'bg-amber-50 text-amber-700',
      approved: 'bg-green-50 text-green-700',
      rejected: 'bg-red-50 text-red-700',
    };
    return map[status];
  };

  const pendingCount = requests.filter((r) => r.status === 'pending').length;

  return (
    <div className="space-y-5">
      <div>
        <h1 className="text-xl font-bold text-gray-900">KYC Review</h1>
        <p className="text-sm text-gray-500">{pendingCount} applications awaiting review</p>
      </div>

      {/* Filter tabs */}
      <div className="flex gap-2">
        {(['all', 'pending', 'approved', 'rejected'] as const).map((tab) => (
          <button
            key={tab}
            onClick={() => setFilter(tab)}
            className={`px-4 py-2 rounded-xl text-sm font-medium transition-colors capitalize ${
              filter === tab
                ? 'bg-green-600 text-white'
                : 'bg-white border border-gray-200 text-gray-600 hover:bg-gray-50'
            }`}
          >
            {tab}
          </button>
        ))}
      </div>

      {/* Cards */}
      <div className="grid gap-4">
        {filtered.map((req) => (
          <div key={req.id} className="bg-white rounded-2xl border border-gray-100 p-5">
            <div className="flex items-start justify-between gap-4">
              <div className="flex items-center gap-4">
                <div className="w-12 h-12 bg-gray-100 rounded-xl flex items-center justify-center text-gray-500 font-bold text-lg">
                  {req.userName[0]}
                </div>
                <div>
                  <h3 className="font-semibold text-gray-900">{req.userName}</h3>
                  <p className="text-sm text-gray-400">{req.phone}</p>
                  <p className="text-xs text-gray-400 mt-0.5">Submitted: {req.submittedAt}</p>
                </div>
              </div>
              <div className="flex items-center gap-2">
                <span className={`px-3 py-1 rounded-full text-xs font-medium ${badgeClass(req.status)}`}>
                  {req.status}
                </span>
              </div>
            </div>

            {/* Document placeholders */}
            <div className="mt-4 grid grid-cols-3 gap-3">
              {['Citizenship Front', 'Citizenship Back', 'Selfie'].map((doc) => (
                <div key={doc} className="bg-gray-50 rounded-xl h-24 flex flex-col items-center justify-center gap-1 border border-dashed border-gray-200">
                  <div className="text-2xl">🪪</div>
                  <span className="text-xs text-gray-400">{doc}</span>
                </div>
              ))}
            </div>

            {req.status === 'pending' && (
              <div className="mt-4 flex gap-2">
                <button
                  onClick={() => updateStatus(req.id, 'approved')}
                  className="flex items-center gap-2 px-4 py-2 bg-green-600 text-white rounded-xl text-sm hover:bg-green-700 transition-colors"
                >
                  <Check size={16} />
                  Approve
                </button>
                <button
                  onClick={() => updateStatus(req.id, 'rejected')}
                  className="flex items-center gap-2 px-4 py-2 bg-red-50 text-red-700 border border-red-200 rounded-xl text-sm hover:bg-red-100 transition-colors"
                >
                  <X size={16} />
                  Reject
                </button>
              </div>
            )}
          </div>
        ))}

        {filtered.length === 0 && (
          <div className="bg-white rounded-2xl border border-gray-100 p-12 text-center text-gray-400">
            No {filter === 'all' ? '' : filter} KYC applications
          </div>
        )}
      </div>
    </div>
  );
};

export default KycPage;
