import 'package:fit_flow/core/utils/keyboard_aware_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/auth_header_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/bottom_auth_section.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/main_auth_section.dart';
import 'package:flutter/material.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const KeyboardAwareScroll(
      child: Column(
        children: [
          AuthHeaderSection(),
          SizedBox(height: 20),
          MainAuthSection(),
          SizedBox(height: 20),
          BottomAuthSection(),
        ],
      ),
    );
  }
}
