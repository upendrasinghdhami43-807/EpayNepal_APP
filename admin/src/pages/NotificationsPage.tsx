import React, { useState } from 'react';
import { Send } from 'lucide-react';

const NotificationsPage: React.FC = () => {
  const [title, setTitle] = useState('');
  const [body, setBody] = useState('');
  const [target, setTarget] = useState('all');
  const [sent, setSent] = useState(false);

  const handleSend = (e: React.FormEvent) => {
    e.preventDefault();
    setSent(true);
    setTimeout(() => {
      setSent(false);
      setTitle('');
      setBody('');
    }, 2000);
  };

  const history = [
    { id: 1, title: 'System Maintenance', body: 'Scheduled maintenance on Jan 12...', target: 'All Users', sentAt: '2025-01-08 18:00' },
    { id: 2, title: '50% Cashback Offer!', body: 'Use EpayNepal for NEA bill and get 50 FonePOINTS', target: 'All Users', sentAt: '2025-01-06 10:30' },
    { id: 3, title: 'KYC Reminder', body: 'Complete your KYC to unlock higher limits', target: 'Unverified', sentAt: '2025-01-05 09:00' },
  ];

  return (
    <div className="space-y-5">
      <div>
        <h1 className="text-xl font-bold text-gray-900">Notifications</h1>
        <p className="text-sm text-gray-500">Send push/SMS notifications to users</p>
      </div>

      {/* Send form */}
      <div className="bg-white rounded-2xl border border-gray-100 p-5">
        <h2 className="text-sm font-semibold text-gray-700 mb-4">Send Notification</h2>
        {sent && (
          <div className="mb-4 p-3 bg-green-50 border border-green-200 rounded-xl text-sm text-green-700">
            ✓ Notification sent successfully!
          </div>
        )}
        <form onSubmit={handleSend} className="space-y-4">
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-1">Target Audience</label>
            <select
              value={target}
              onChange={(e) => setTarget(e.target.value)}
              className="w-full border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-500"
            >
              <option value="all">All Users</option>
              <option value="unverified">Unverified Users</option>
              <option value="inactive">Inactive Users (&gt;30 days)</option>
              <option value="premium">KYC Verified</option>
            </select>
          </div>
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-1">Title</label>
            <input
              type="text"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              placeholder="Notification title..."
              required
              className="w-full border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-500"
            />
          </div>
          <div>
            <label className="block text-xs font-medium text-gray-600 mb-1">Message</label>
            <textarea
              value={body}
              onChange={(e) => setBody(e.target.value)}
              placeholder="Notification body..."
              rows={3}
              required
              className="w-full border border-gray-200 rounded-xl px-3 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 resize-none"
            />
          </div>
          <button
            type="submit"
            className="flex items-center gap-2 px-5 py-2.5 bg-green-600 text-white rounded-xl text-sm font-medium hover:bg-green-700 transition-colors"
          >
            <Send size={16} />
            Send Notification
          </button>
        </form>
      </div>

      {/* History */}
      <div className="bg-white rounded-2xl border border-gray-100 p-5">
        <h2 className="text-sm font-semibold text-gray-700 mb-4">Sent History</h2>
        <div className="space-y-3">
          {history.map((n) => (
            <div key={n.id} className="flex items-start gap-3 p-3 rounded-xl bg-gray-50">
              <div className="w-8 h-8 bg-green-100 rounded-lg flex items-center justify-center text-green-700 shrink-0">
                <Send size={14} />
              </div>
              <div className="flex-1 min-w-0">
                <p className="font-medium text-sm text-gray-800">{n.title}</p>
                <p className="text-xs text-gray-500 truncate">{n.body}</p>
                <p className="text-xs text-gray-400 mt-0.5">{n.target} · {n.sentAt}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default NotificationsPage;
