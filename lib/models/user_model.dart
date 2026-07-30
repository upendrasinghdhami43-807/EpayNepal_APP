class UserModel {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String? avatarUrl;
  final bool isVerified;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.avatarUrl,
    this.isVerified = false,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      isVerified: (json['is_verified'] as bool?) ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'avatar_url': avatarUrl,
        'is_verified': isVerified,
        'created_at': createdAt?.toIso8601String(),
      };

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? avatarUrl,
    bool? isVerified,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static UserModel get demo => const UserModel(
        id: 'demo-001',
        name: 'Upendra Dhami',
        phone: '9841234567',
        email: 'upendra@epaynepal.com',
        isVerified: true,
      );
}
