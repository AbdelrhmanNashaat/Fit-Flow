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
    required this.userName,
    required this.appVersion,
    this.localImagePath,
    this.isImageUploading = false,
  });

  final UserProfile profile;
  final String userName;
  final String appVersion;

  /// Absolute path to the locally saved profile image, or null if none.
  final String? localImagePath;

  /// True while a profile picture save is in progress.
  final bool isImageUploading;

  ProfileLoaded copyWith({
    UserProfile? profile,
    String? userName,
    String? appVersion,
    String? localImagePath,
    bool? isImageUploading,
  }) {
    return ProfileLoaded(
      profile: profile ?? this.profile,
      userName: userName ?? this.userName,
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
