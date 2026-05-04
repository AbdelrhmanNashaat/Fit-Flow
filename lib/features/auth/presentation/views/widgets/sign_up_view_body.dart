import 'package:fit_flow/features/auth/presentation/views/widgets/auth_header_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/main_auth_section.dart';
import 'package:flutter/material.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AuthHeaderSection(),
            SizedBox(height: 60),
            MainAuthSection(),
          ],
        ),
      ),
    );
  }
}
