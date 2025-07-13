import 'package:flutter/material.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String? phone;
  final double walletBalance;
  final String profilePicture;
  final UserRole role;
  final bool isBanned;
  final bool isExpert;
  final bool isVerified;
  final bool isBlocked;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    this.phone,
    this.walletBalance = 0.0,
    this.profilePicture = '',
    this.role = UserRole.user,
    this.isBanned = false,
    this.isExpert = false,
    this.isVerified = false,
    this.isBlocked = false,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor for creating User from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? json['id'],
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      walletBalance: (json['walletBalance'] ?? 0).toDouble(),
      profilePicture: json['profilePicture'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRole.user,
      ),
      isBanned: json['isBanned'] ?? false,
      isExpert: json['isExpert'] ?? false,
      isVerified: json['isVerified'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  // Method to convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'fullName': fullName,
      'email': email,
      if (phone != null) 'phone': phone,
      'walletBalance': walletBalance,
      'profilePicture': profilePicture,
      'role': role.name,
      'isBanned': isBanned,
      'isExpert': isExpert,
      'isVerified': isVerified,
      'isBlocked': isBlocked,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  // CopyWith method for creating modified copies
  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    double? walletBalance,
    String? profilePicture,
    UserRole? role,
    bool? isBanned,
    bool? isExpert,
    bool? isVerified,
    bool? isBlocked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      walletBalance: walletBalance ?? this.walletBalance,
      profilePicture: profilePicture ?? this.profilePicture,
      role: role ?? this.role,
      isBanned: isBanned ?? this.isBanned,
      isExpert: isExpert ?? this.isExpert,
      isVerified: isVerified ?? this.isVerified,
      isBlocked: isBlocked ?? this.isBlocked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Check if user can access the platform
  bool get canAccess => !isBanned && !isBlocked;

  // Check if user is admin
  bool get isAdmin => role == UserRole.admin;

  // Get display name (fallback to email if no fullName)
  String get displayName => fullName.isNotEmpty ? fullName : email;

  // Get formatted wallet balance
  String get formattedWalletBalance => '\$${walletBalance.toStringAsFixed(2)}';

  @override
  String toString() {
    return 'UserModel(id: $id, fullName: $fullName, email: $email, role: $role, walletBalance: $walletBalance)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Enum for User Role
enum UserRole {
  user,
  admin,
}

// Extension for UserRole
extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.user:
        return 'User';
      case UserRole.admin:
        return 'Admin';
    }
  }

  Color get color {
    switch (this) {
      case UserRole.user:
        return Colors.blue;
      case UserRole.admin:
        return Colors.red;
    }
  }
}
