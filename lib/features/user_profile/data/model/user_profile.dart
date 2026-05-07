import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  const UserProfile({
    required this.uid,
    required this.email,
    required this.isOnboardingCompleted,
    required this.createdAt,
    this.name,
    this.myGoal,
    this.weeklyAvailability,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String?,
      myGoal: json['myGoal'] as String?,
      weeklyAvailability: json['weeklyAvailability'] as int?,
      isOnboardingCompleted: json['isOnboardingCompleted'] as bool? ?? false,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  final String uid;
  final String email;
  final String? name;
  final String? myGoal;
  final int? weeklyAvailability;
  final bool isOnboardingCompleted;
  final DateTime createdAt;

  UserProfile copyWith({
    String? uid,
    String? email,
    String? name,
    String? myGoal,
    int? weeklyAvailability,
    bool? isOnboardingCompleted,
    DateTime? createdAt,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      myGoal: myGoal ?? this.myGoal,
      weeklyAvailability: weeklyAvailability ?? this.weeklyAvailability,
      isOnboardingCompleted:
          isOnboardingCompleted ?? this.isOnboardingCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'myGoal': myGoal,
      'weeklyAvailability': weeklyAvailability,
      'isOnboardingCompleted': isOnboardingCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
