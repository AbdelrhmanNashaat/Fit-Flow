import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/core/widgets/app_confirm_dialog.dart';
import 'package:fit_flow/core/widgets/custom_app_bar.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:fit_flow/features/locale/cubit/locale_cubit.dart';
import 'package:fit_flow/features/user_profile/presentation/cubit/profile_cubit.dart';
import 'package:fit_flow/features/user_profile/presentation/cubit/profile_state.dart';
import 'package:fit_flow/features/user_profile/presentation/views/widgets/language_bottom_sheet.dart';
import 'package:fit_flow/features/user_profile/presentation/views/widgets/profile_header_card.dart';
import 'package:fit_flow/features/user_profile/presentation/views/widgets/profile_legal_section.dart';
import 'package:fit_flow/features/user_profile/presentation/views/widgets/profile_menu_tile.dart';
import 'package:fit_flow/features/user_profile/presentation/views/widgets/profile_settings_group.dart';
import 'package:fit_flow/features/user_profile/presentation/views/widgets/profile_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSettingsViewBody extends StatelessWidget {
  const ProfileSettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthSessionCubit, AuthSessionState>(
          listenWhen: (_, curr) => curr is AuthSessionNeedsReauth,
          listener: (context, state) {
            if (state is AuthSessionNeedsReauth &&
                state.provider == 'password') {
              _showReauthDialog(context);
            }
          },
        ),
        BlocListener<AuthSessionCubit, AuthSessionState>(
          listenWhen: (_, curr) =>
              curr is AuthSessionFailure && curr.user != null,
          listener: (context, state) {
            if (state is AuthSessionFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) => switch (state) {
          ProfileInitial() || ProfileLoading() => const ProfileShimmer(),
          ProfileError(:final message) => Center(
            child: Text(
              message,
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ProfileLoaded() => _ProfileContent(state: state),
        },
      ),
    );
  }

  void _showReauthDialog(BuildContext context) {
    final authCubit = context.read<AuthSessionCubit>();
    showDialog<void>(
      context: context,
      builder: (_) => _ReauthDialog(
        onConfirm: (password) => authCubit.deleteAccount(password: password),
      ),
    );
  }
}

class _ReauthDialog extends StatefulWidget {
  const _ReauthDialog({required this.onConfirm});
  final void Function(String password) onConfirm;

  @override
  State<_ReauthDialog> createState() => _ReauthDialogState();
}

class _ReauthDialogState extends State<_ReauthDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.reauthTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.reauthMessage),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            obscureText: true,
            decoration: InputDecoration(labelText: l10n.passwordLabel),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onConfirm(_controller.text.trim());
          },
          child: Text(
            l10n.delete,
            style: const TextStyle(color: AppColors.error),
          ),
        ),
      ],
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.state});

  final ProfileLoaded state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final currentLang = context.watch<LocaleCubit>().state.languageCode;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarWidget(
                title: l10n.healthProfile,
                trailing: const Icon(
                  Icons.settings_outlined,
                  color: AppColors.primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ProfileHeaderCard(
                      userName: state.displayName,
                      profile: state.profile,
                      localImagePath: state.localImagePath,
                      isImageUploading: state.isImageUploading,
                      onEditTap: () {
                        final authState = context
                            .read<AuthSessionCubit>()
                            .state;
                        final uid = switch (authState) {
                          AuthSessionAuthenticated(:final user) => user.id,
                          _ => null,
                        };
                        if (uid != null) {
                          context.read<ProfileCubit>().pickAndSaveImage(uid);
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    ProfileSettingsGroup(
                      label: l10n.preferencesAccount,
                      children: [
                        ProfileMenuTile(
                          icon: Icons.language_rounded,
                          label: l10n.language,
                          trailingText: currentLang == 'ar'
                              ? l10n.arabic
                              : l10n.english,
                          isLanguage: true,
                          onTap: () => LanguageBottomSheet.show(context),
                        ),
                        ProfileMenuTile(
                          icon: Icons.restart_alt_rounded,
                          label: l10n.resetWorkoutPlan,
                          onTap: () => _confirmReset(context, l10n),
                        ),
                        ProfileMenuTile(
                          icon: Icons.logout_rounded,
                          label: l10n.logOut,
                          onTap: () => _confirmSignOut(context, l10n),
                        ),
                        ProfileMenuTile(
                          icon: Icons.delete_outline_rounded,
                          label: l10n.deleteAccount,
                          isDestructive: true,
                          onTap: () => _confirmDeleteAccount(context, l10n),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const ProfileLegalSection(),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        l10n.appVersion(state.appVersion),
                        style: AppTextStyles.regular14.copyWith(
                          color: AppColors.orTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _confirmSignOut(BuildContext context, S l10n) {
    final authCubit = context.read<AuthSessionCubit>();
    AppConfirmDialog.show(
      context,
      title: l10n.logOutConfirmTitle,
      message: l10n.logOutConfirmMessage,
      confirmLabel: l10n.logOut,
      cancelLabel: l10n.cancel,
      isDestructive: true,
      onConfirm: authCubit.signOut,
    );
  }

  void _confirmReset(BuildContext context, S l10n) {
    final authCubit = context.read<AuthSessionCubit>();
    AppConfirmDialog.show(
      context,
      title: l10n.resetPlanTitle,
      message: l10n.resetPlanMessage,
      confirmLabel: l10n.reset,
      cancelLabel: l10n.cancel,
      onConfirm: authCubit.resetAndStartOnboarding,
    );
  }

  void _confirmDeleteAccount(BuildContext context, S l10n) {
    final authCubit = context.read<AuthSessionCubit>();
    AppConfirmDialog.show(
      context,
      title: l10n.deleteAccountTitle,
      message: l10n.deleteAccountMessage,
      confirmLabel: l10n.delete,
      cancelLabel: l10n.cancel,
      isDestructive: true,
      onConfirm: authCubit.deleteAccount,
    );
  }
}
