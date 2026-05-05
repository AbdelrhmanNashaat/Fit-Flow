import 'package:fit_flow/core/utils/app_assets.dart';
import 'package:fit_flow/core/widgets/custom_button_with_image.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_in_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RowOFSignInOptionsButtons extends StatelessWidget {
  const RowOFSignInOptionsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignInCubit, SignInState, (bool, bool)>(
      selector: (state) =>
          (state is SignInLoading, state is SignInLoading && state.isGoogle),
      builder: (context, loading) {
        final (isAnyLoading, isGoogleLoading) = loading;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: CustomButtonWithImage(
                imagePath: Assets.googleLogo,
                text: 'Google',
                isLoading: isGoogleLoading,
                onPressed: isAnyLoading
                    ? () {}
                    : () => context.read<SignInCubit>().signInWithGoogle(),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: CustomButtonWithImage(
                imagePath: Assets.appleLogo,
                text: 'Apple',
                isLoading: false,
                onPressed: isAnyLoading ? () {} : () {},
              ),
            ),
          ],
        );
      },
    );
  }
}
