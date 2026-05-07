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
      create: (_) =>
          ProfileCubit(getIt<UserProfileRepo>())
            ..loadProfile(user.id, _displayNameFor(user)),
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

  String _displayNameFor(AuthUser user) {
    final trimmedName = user.name.trim();
    if (trimmedName.isNotEmpty) return trimmedName;

    final trimmedEmail = user.email.trim();
    if (trimmedEmail.isEmpty) return 'FitFlow Member';

    final emailHandle = trimmedEmail.split('@').first.trim();
    if (emailHandle.isEmpty) return 'FitFlow Member';

    return emailHandle
        .split(RegExp(r'[._-]+'))
        .where((segment) => segment.isNotEmpty)
        .map(
          (segment) =>
              '${segment[0].toUpperCase()}${segment.substring(1).toLowerCase()}',
        )
        .join(' ');
  }
}
