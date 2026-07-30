class WalletModel {
  final String id;
  final String userId;
  final double balance;
  final double rewardPoints;
  final DateTime? updatedAt;

  const WalletModel({
    required this.id,
    required this.userId,
    required this.balance,
    this.rewardPoints = 0.0,
    this.updatedAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      rewardPoints: (json['reward_points'] as num?)?.toDouble() ?? 0.0,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'balance': balance,
        'reward_points': rewardPoints,
        'updated_at': updatedAt?.toIso8601String(),
      };

  static WalletModel get demo => const WalletModel(
        id: 'wallet-001',
        userId: 'demo-001',
        balance: 45280.50,
        rewardPoints: 1240.0,
      );
}
