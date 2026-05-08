import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/core/utils/future_utils.dart';
import 'package:fit_flow/features/user_profile/data/model/user_profile.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:fit_flow/features/user_profile/presentation/cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required UserProfileRepo userProfileRepo,
    required ImagePicker imagePicker,
  }) : _userProfileRepo = userProfileRepo,
       _imagePicker = imagePicker,
       super(const ProfileInitial());

  final UserProfileRepo _userProfileRepo;
  final ImagePicker _imagePicker;

  Future<void> loadProfile(String uid) async {
    emit(const ProfileLoading());

    final (profileResult, packageInfo) = await (
      _userProfileRepo.getProfile(uid),
      PackageInfo.fromPlatform(),
    ).wait;

    final localImagePath = _userProfileRepo.getCachedImagePath(uid);

    final Either<Failure, UserProfile?> typed = profileResult;
    typed.fold(
      (failure) => emit(ProfileError(failure.message)),
      (profile) {
        if (profile == null) {
          emit(const ProfileError('Profile not found'));
          return;
        }
        emit(
          ProfileLoaded(
            profile: profile,
            appVersion: packageInfo.version,
            localImagePath: localImagePath,
          ),
        );
      },
    );
  }

  Future<void> pickAndSaveImage(String uid) async {
    final loaded = state;
    if (loaded is! ProfileLoaded) return;

    try {
      final picked = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (picked == null) return;

      emit(loaded.copyWith(isImageUploading: true));

      final bytes = await picked.readAsBytes();
      final result = await _userProfileRepo.saveProfileImageLocally(uid, bytes);

      result.fold(
        (failure) {
          log(failure.message, name: 'ProfileCubit');
          emit(loaded.copyWith(isImageUploading: false));
        },
        (path) => emit(
          loaded.copyWith(localImagePath: path, isImageUploading: false),
        ),
      );
    } catch (e) {
      log(e.toString(), name: 'ProfileCubit');
      emit(loaded.copyWith(isImageUploading: false));
    }
  }
}
