import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatelessWidget {
  const MainView({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _BottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        l10n: l10n,
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.currentIndex,
    required this.onTap,
    required this.l10n,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: AppColors.buttonColor,
      unselectedItemColor: AppColors.orTextColor,
      backgroundColor: AppColors.whiteColor,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home_rounded),
          label: l10n.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.menu_book_outlined),
          activeIcon: const Icon(Icons.menu_book_rounded),
          label: l10n.learn,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline_rounded),
          activeIcon: const Icon(Icons.person_rounded),
          label: l10n.profile,
        ),
      ],
    );
  }
}

