import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  const UserProfile({
    required this.uid,
    required this.email,
    required this.isOnboardingCompleted,
    required this.createdAt,
    this.myGoal,
    this.weeklyAvailability,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      myGoal: json['myGoal'] as String?,
      weeklyAvailability: json['weeklyAvailability'] as int?,
      isOnboardingCompleted: json['isOnboardingCompleted'] as bool? ?? false,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  final String uid;
  final String email;
  final String? myGoal;
  final int? weeklyAvailability;
  final bool isOnboardingCompleted;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'myGoal': myGoal,
      'weeklyAvailability': weeklyAvailability,
      'isOnboardingCompleted': isOnboardingCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
