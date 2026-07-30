import React, { useState } from 'react';
import { MessageCircle, CheckCircle2 } from 'lucide-react';

const tickets = [
  { id: 'tk1', user: 'Upendra Dhami', subject: 'Transaction not reflected', status: 'open', date: '2025-01-10' },
  { id: 'tk2', user: 'Sita Sharma', subject: 'KYC rejected unfairly', status: 'open', date: '2025-01-09' },
  { id: 'tk3', user: 'Ram Bahadur', subject: 'App crashing on bill pay', status: 'resolved', date: '2025-01-08' },
  { id: 'tk4', user: 'Kamala Thapa', subject: 'Unable to link bank account', status: 'open', date: '2025-01-07' },
];

const SupportPage: React.FC = () => {
  const [items, setItems] = useState(tickets);

  const resolve = (id: string) =>
    setItems((prev) =>
      prev.map((t) => (t.id === id ? { ...t, status: 'resolved' } : t))
    );

  return (
    <div className="space-y-5">
      <div>
        <h1 className="text-xl font-bold text-gray-900">Support Tickets</h1>
        <p className="text-sm text-gray-500">{items.filter((t) => t.status === 'open').length} open tickets</p>
      </div>

      <div className="grid gap-4">
        {items.map((ticket) => (
          <div key={ticket.id} className="bg-white rounded-2xl border border-gray-100 p-5 flex items-start gap-4">
            <div className="w-10 h-10 bg-blue-50 rounded-xl flex items-center justify-center shrink-0">
              <MessageCircle size={20} className="text-blue-600" />
            </div>
            <div className="flex-1">
              <div className="flex items-center justify-between gap-4">
                <h3 className="font-semibold text-gray-900">{ticket.subject}</h3>
                <span
                  className={`px-2 py-0.5 rounded-full text-xs font-medium ${
                    ticket.status === 'open'
                      ? 'bg-amber-50 text-amber-700'
                      : 'bg-green-50 text-green-700'
                  }`}
                >
                  {ticket.status}
                </span>
              </div>
              <p className="text-sm text-gray-500 mt-0.5">{ticket.user} · {ticket.date}</p>
            </div>
            {ticket.status === 'open' && (
              <button
                onClick={() => resolve(ticket.id)}
                className="flex items-center gap-1.5 px-3 py-2 bg-green-50 text-green-700 rounded-xl text-sm hover:bg-green-100 transition-colors shrink-0"
              >
                <CheckCircle2 size={14} />
                Resolve
              </button>
            )}
          </div>
        ))}
      </div>
    </div>
  );
};

export default SupportPage;
