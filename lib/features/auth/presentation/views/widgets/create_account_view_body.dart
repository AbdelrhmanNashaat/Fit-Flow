import 'package:fit_flow/features/auth/presentation/views/widgets/create_account_bottom_section.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/create_account_header_section.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/create_account_main_section.dart';
import 'package:flutter/material.dart';

class CreateAccountViewBody extends StatelessWidget {
  const CreateAccountViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CreateAccountHeaderSection(),
              SizedBox(height: 20),
              CreateAccountMainSection(),
              SizedBox(height: 20),
              CreateAccountBottomSection(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
