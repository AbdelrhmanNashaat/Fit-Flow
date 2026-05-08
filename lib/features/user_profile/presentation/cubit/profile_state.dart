import 'package:fit_flow/features/user_profile/data/model/user_profile.dart';

sealed class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded({
    required this.profile,
    required this.appVersion,
    this.localImagePath,
    this.isImageUploading = false,
  });

  final UserProfile profile;
  final String appVersion;
  final String? localImagePath;
  final bool isImageUploading;

  String get displayName {
    final name = profile.name;
    if (name != null && name.isNotEmpty) return name;
    final email = profile.email;
    final handle = email.split('@').first.trim();
    if (handle.isEmpty) return 'FitFlow Member';
    return handle
        .split(RegExp(r'[._-]+'))
        .where((s) => s.isNotEmpty)
        .map((s) => '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}')
        .join(' ');
  }

  ProfileLoaded copyWith({
    UserProfile? profile,
    String? appVersion,
    String? localImagePath,
    bool? isImageUploading,
  }) {
    return ProfileLoaded(
      profile: profile ?? this.profile,
      appVersion: appVersion ?? this.appVersion,
      localImagePath: localImagePath ?? this.localImagePath,
      isImageUploading: isImageUploading ?? this.isImageUploading,
    );
  }
}

class ProfileError extends ProfileState {
  const ProfileError(this.message);

  final String message;
}
