import 'package:fit_flow/features/auth/presentation/views/widgets/auth_header_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/bottom_auth_section.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/main_auth_section.dart';
import 'package:flutter/material.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: const IntrinsicHeight(
                child: Column(
                  children: [
                    AuthHeaderSection(),
                    SizedBox(height: 60),
                    MainAuthSection(),
                    SizedBox(height: 40),
                    BottomAuthSection(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
