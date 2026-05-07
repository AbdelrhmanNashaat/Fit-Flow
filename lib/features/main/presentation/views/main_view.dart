import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/features/home/presentation/views/home_view.dart';
import 'package:fit_flow/features/learn/presentation/views/learn_view.dart';
import 'package:fit_flow/features/main/presentation/cubit/main_cubit.dart';
import 'package:fit_flow/features/user_profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

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

class _MainScaffold extends StatefulWidget {
  const _MainScaffold();

  @override
  State<_MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<_MainScaffold> {
  late final PersistentTabController _controller;

  static const List<Widget> _screens = [HomeView(), LearnView(), ProfileView()];

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(
      initialIndex: context.read<MainCubit>().state,
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems(AppLocalizations l10n) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_rounded),
        inactiveIcon: const Icon(Icons.home_outlined),
        title: l10n.home,
        activeColorPrimary: AppColors.buttonColor,
        activeColorSecondary: AppColors.whiteColor,
        inactiveColorPrimary: AppColors.orTextColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.menu_book_rounded),
        inactiveIcon: const Icon(Icons.menu_book_outlined),
        title: l10n.learn,
        activeColorPrimary: AppColors.buttonColor,
        activeColorSecondary: AppColors.whiteColor,
        inactiveColorPrimary: AppColors.orTextColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_rounded),
        inactiveIcon: const Icon(Icons.person_outline_rounded),
        title: l10n.profile,
        activeColorPrimary: AppColors.buttonColor,
        activeColorSecondary: AppColors.whiteColor,
        inactiveColorPrimary: AppColors.orTextColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<MainCubit, int>(
      listenWhen: (previous, current) => previous != current,
      listener: (_, tab) {
        if (_controller.index != tab) {
          _controller.index = tab;
        }
      },
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _screens,
        items: _navBarsItems(l10n),
        backgroundColor: AppColors.whiteColor,
        navBarStyle: NavBarStyle.style10,
        decoration: NavBarDecoration(
          colorBehindNavBar: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 18,
              offset: Offset(0, -4),
            ),
          ],
        ),
        confineToSafeArea: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        handleAndroidBackButtonPress: true,
        hideNavigationBarWhenKeyboardAppears: true,
        popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        onItemSelected: context.read<MainCubit>().setTab,
        animationSettings: const NavBarAnimationSettings(
          screenTransitionAnimation: ScreenTransitionAnimationSettings(
            animateTabTransition: true,
            curve: Curves.easeOutCubic,
            duration: Duration(milliseconds: 250),
          ),
        ),
      ),
    );
  }
}
