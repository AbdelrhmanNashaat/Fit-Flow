import 'package:fit_flow/core/service/service_locator.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:fit_flow/features/home/presentation/cubit/home_cubit.dart';
import 'package:fit_flow/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:fit_flow/features/workout/domain/repo/workout_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final authState = context.watch<AuthSessionCubit>().state;
    final userName = switch (authState) {
      AuthSessionAuthenticated(:final user) => user.name,
      _ => '',
    };

    return BlocProvider(
      create: (_) => HomeCubit(getIt<WorkoutRepo>())..load(userName),
      child: const HomeViewBody(),
    );
=======
    return const SafeArea(child: HomeViewBody());
>>>>>>> 6e1e05bb329e007ed72045362810255f370f1d26
  }
}
