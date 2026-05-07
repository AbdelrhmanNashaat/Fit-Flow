import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/features/home/presentation/views/home_view.dart';
import 'package:fit_flow/features/main/presentation/cubit/main_cubit.dart';
import 'package:fit_flow/features/user_profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainCubit(),
      child: const _MainScaffold(),
    );
  }
}

class _MainScaffold extends StatelessWidget {
  const _MainScaffold();

  @override
  Widget build(BuildContext context) {
    final tab = context.watch<MainCubit>().state;
    final l10n = context.l10n;

    return Scaffold(
      body: IndexedStack(
        index: tab,
        children: const [
          HomeView(),
          _PlaceholderTab(icon: Icons.directions_run_rounded, label: 'Activity'),
          _PlaceholderTab(icon: Icons.monitor_heart_rounded, label: 'Vitals'),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tab,
        onTap: context.read<MainCubit>().setTab,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.buttonColor,
        unselectedItemColor: AppColors.orTextColor,
        backgroundColor: AppColors.whiteColor,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home_rounded),
            label: l10n.summary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.directions_run_outlined),
            activeIcon: const Icon(Icons.directions_run_rounded),
            label: l10n.activity,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.monitor_heart_outlined),
            activeIcon: const Icon(Icons.monitor_heart_rounded),
            label: l10n.vitals,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline_rounded),
            activeIcon: const Icon(Icons.person_rounded),
            label: l10n.profile,
          ),
        ],
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: AppColors.orTextColor),
            const SizedBox(height: 12),
            Text(label),
          ],
        ),
      ),
    );
  }
}
