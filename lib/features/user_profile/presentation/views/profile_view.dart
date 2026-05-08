import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/service/service_locator.dart';
import 'package:fit_flow/features/auth/data/model/auth_user.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:fit_flow/features/user_profile/presentation/cubit/profile_cubit.dart';
import 'package:fit_flow/features/user_profile/presentation/views/widgets/profile_settings_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = _resolveUser(context.read<AuthSessionCubit>().state);
    if (user == null) {
      return SafeArea(
        child: Center(
          child: Text(context.l10n.profileUnavailable),
        ),
      );
    }

    return BlocProvider(
      create: (_) => ProfileCubit(
        userProfileRepo: getIt<UserProfileRepo>(),
        imagePicker: getIt<ImagePicker>(),
      )..loadProfile(user.id),
      child: const SafeArea(child: ProfileSettingsViewBody()),
    );
  }

  AuthUser? _resolveUser(AuthSessionState state) {
    return switch (state) {
      AuthSessionAuthenticated(:final user) => user,
      AuthSessionSigningOut(:final user) => user,
      AuthSessionFailure(:final user?) => user,
      _ => null,
    };
  }
}
