import 'package:fit_flow/features/auth/presentation/views/widgets/create_account_view_body.dart';
import 'package:flutter/material.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: CreateAccountViewBody()));
  }
}
