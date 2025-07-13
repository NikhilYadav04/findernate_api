import 'package:flutter/material.dart';

class ExpertModel {
  final String? id;
  final String userId;
  final String categoryId;
  final String subcategory;
  final String fullName;
  final String? email;
  final String? phone;
  final String? bio;
  final String? expertise;
  final int? experienceYears;
  final String? currentCompany;
  final String? currentDesignation;
  final String? linkedinUrl;
  final double ratePerMinute;
  final double rating;
  final int reviewsCount;
  final String profilePicture;
  final String? degreeCertificateUrl;
  final String? idProofUrl;
  final String? offerLetterUrl;
  final String? otherCertificateUrl;
  final ExpertStatus status;
  final bool isApproved;
  final bool isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ExpertModel({
    this.id,
    required this.userId,
    required this.categoryId,
    this.subcategory = '',
    required this.fullName,
    this.email,
    this.phone,
    this.bio,
    this.expertise,
    this.experienceYears,
    this.currentCompany,
    this.currentDesignation,
    this.linkedinUrl,
    required this.ratePerMinute,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.profilePicture = '',
    this.degreeCertificateUrl,
    this.idProofUrl,
    this.offerLetterUrl,
    this.otherCertificateUrl,
    this.status = ExpertStatus.pending,
    this.isApproved = false,
    this.isAvailable = true,
    this.createdAt,
    this.updatedAt,
  });

  factory ExpertModel.fromJson(Map<String, dynamic> json) {
    return ExpertModel(
      id: json['_id'] ?? json['id'],
      userId: json['userId'] ?? '',
      categoryId: json['categoryId'] ?? '',
      subcategory: json['subcategory'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'],
      phone: json['phone'],
      bio: json['bio'],
      expertise: json['expertise'],
      experienceYears: json['experienceYears'],
      currentCompany: json['currentCompany'],
      currentDesignation: json['currentDesignation'],
      linkedinUrl: json['linkedinUrl'],
      ratePerMinute: (json['ratePerMinute'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      reviewsCount: json['reviewsCount'] ?? 0,
      profilePicture: json['profilePicture'] ?? '',
      degreeCertificateUrl: json['degreeCertificateUrl'],
      idProofUrl: json['idProofUrl'],
      offerLetterUrl: json['offerLetterUrl'],
      otherCertificateUrl: json['otherCertificateUrl'],
      status: ExpertStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ExpertStatus.pending,
      ),
      isApproved: json['isApproved'] ?? false,
      isAvailable: json['isAvailable'] ?? true,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'userId': userId,
      'categoryId': categoryId,
      'subcategory': subcategory,
      'fullName': fullName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (bio != null) 'bio': bio,
      if (expertise != null) 'expertise': expertise,
      if (experienceYears != null) 'experienceYears': experienceYears,
      if (currentCompany != null) 'currentCompany': currentCompany,
      if (currentDesignation != null) 'currentDesignation': currentDesignation,
      if (linkedinUrl != null) 'linkedinUrl': linkedinUrl,
      'ratePerMinute': ratePerMinute,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'profilePicture': profilePicture,
      if (degreeCertificateUrl != null)
        'degreeCertificateUrl': degreeCertificateUrl,
      if (idProofUrl != null) 'idProofUrl': idProofUrl,
      if (offerLetterUrl != null) 'offerLetterUrl': offerLetterUrl,
      if (otherCertificateUrl != null)
        'otherCertificateUrl': otherCertificateUrl,
      'status': status.name,
      'isApproved': isApproved,
      'isAvailable': isAvailable,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  ExpertModel copyWith({
    String? id,
    String? userId,
    String? categoryId,
    String? subcategory,
    String? fullName,
    String? email,
    String? phone,
    String? bio,
    String? expertise,
    int? experienceYears,
    String? currentCompany,
    String? currentDesignation,
    String? linkedinUrl,
    double? ratePerMinute,
    double? rating,
    int? reviewsCount,
    String? profilePicture,
    String? degreeCertificateUrl,
    String? idProofUrl,
    String? offerLetterUrl,
    String? otherCertificateUrl,
    ExpertStatus? status,
    bool? isApproved,
    bool? isAvailable,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExpertModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      subcategory: subcategory ?? this.subcategory,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      expertise: expertise ?? this.expertise,
      experienceYears: experienceYears ?? this.experienceYears,
      currentCompany: currentCompany ?? this.currentCompany,
      currentDesignation: currentDesignation ?? this.currentDesignation,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
      ratePerMinute: ratePerMinute ?? this.ratePerMinute,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      profilePicture: profilePicture ?? this.profilePicture,
      degreeCertificateUrl: degreeCertificateUrl ?? this.degreeCertificateUrl,
      idProofUrl: idProofUrl ?? this.idProofUrl,
      offerLetterUrl: offerLetterUrl ?? this.offerLetterUrl,
      otherCertificateUrl: otherCertificateUrl ?? this.otherCertificateUrl,
      status: status ?? this.status,
      isApproved: isApproved ?? this.isApproved,
      isAvailable: isAvailable ?? this.isAvailable,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get formattedRate => '\$${ratePerMinute.toStringAsFixed(2)}/min';
  String get formattedRating => rating.toStringAsFixed(1);
  String get experienceText =>
      experienceYears != null ? '$experienceYears years' : 'Not specified';
  bool get canTakeBookings =>
      isApproved && isAvailable && status == ExpertStatus.verified;
  String get displayName => fullName;

  @override
  String toString() {
    return 'ExpertModel(id: $id, fullName: $fullName, status: $status, rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ExpertModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

enum ExpertStatus {
  pending,
  verified,
  rejected,
}

extension ExpertStatusExtension on ExpertStatus {
  String get displayName {
    switch (this) {
      case ExpertStatus.pending:
        return 'Pending';
      case ExpertStatus.verified:
        return 'Verified';
      case ExpertStatus.rejected:
        return 'Rejected';
    }
  }

  Color get color {
    switch (this) {
      case ExpertStatus.pending:
        return Colors.orange;
      case ExpertStatus.verified:
        return Colors.green;
      case ExpertStatus.rejected:
        return Colors.red;
    }
  }

  IconData get icon {
    switch (this) {
      case ExpertStatus.pending:
        return Icons.pending;
      case ExpertStatus.verified:
        return Icons.verified;
      case ExpertStatus.rejected:
        return Icons.cancel;
    }
  }
}
