enum TransactionType { credit, debit, transfer, topUp, withdraw, bill, qr }

enum TransactionStatus { pending, success, failed, reversed }

class TransactionModel {
  final String id;
  final String walletId;
  final TransactionType type;
  final TransactionStatus status;
  final double amount;
  final String description;
  final String? recipientName;
  final String? recipientPhone;
  final DateTime createdAt;
  final String? referenceCode;

  const TransactionModel({
    required this.id,
    required this.walletId,
    required this.type,
    required this.status,
    required this.amount,
    required this.description,
    this.recipientName,
    this.recipientPhone,
    required this.createdAt,
    this.referenceCode,
  });

  bool get isDebit =>
      type == TransactionType.debit ||
      type == TransactionType.transfer ||
      type == TransactionType.withdraw ||
      type == TransactionType.bill ||
      type == TransactionType.qr;

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id']?.toString() ?? '',
      walletId: json['wallet_id']?.toString() ?? '',
      type: TransactionType.values.firstWhere(
        (e) => e.name == (json['type'] as String?),
        orElse: () => TransactionType.debit,
      ),
      status: TransactionStatus.values.firstWhere(
        (e) => e.name == (json['status'] as String?),
        orElse: () => TransactionStatus.pending,
      ),
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      recipientName: json['recipient_name'] as String?,
      recipientPhone: json['recipient_phone'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ??
          DateTime.now(),
      referenceCode: json['reference_code'] as String?,
    );
  }

  static List<TransactionModel> get demoList => [
        TransactionModel(
          id: 'txn-001',
          walletId: 'wallet-001',
          type: TransactionType.transfer,
          status: TransactionStatus.success,
          amount: 500.0,
          description: 'Sent to Lalita Dhami',
          recipientName: 'Lalita Dhami',
          recipientPhone: '9812345678',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          referenceCode: '1N7UKSX',
        ),
        TransactionModel(
          id: 'txn-002',
          walletId: 'wallet-001',
          type: TransactionType.topUp,
          status: TransactionStatus.success,
          amount: 5000.0,
          description: 'Loaded from NIC Asia Bank',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          referenceCode: '9GHK3PQ',
        ),
        TransactionModel(
          id: 'txn-003',
          walletId: 'wallet-001',
          type: TransactionType.bill,
          status: TransactionStatus.success,
          amount: 100.0,
          description: 'Mobile Topup - 9801XXXXXX',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          referenceCode: 'MB100XY',
        ),
        TransactionModel(
          id: 'txn-004',
          walletId: 'wallet-001',
          type: TransactionType.bill,
          status: TransactionStatus.success,
          amount: 1200.0,
          description: 'Worldlink Internet Bill',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          referenceCode: 'INT12AB',
        ),
      ];
}
