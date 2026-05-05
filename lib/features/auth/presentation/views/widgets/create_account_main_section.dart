import 'package:fit_flow/core/widgets/custom_button.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/auth_container_parent_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/create_account_fields_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/or_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/row_oF_sign_in_options_buttons.dart';
import 'package:flutter/material.dart';

class CreateAccountMainSection extends StatelessWidget {
  const CreateAccountMainSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthContainerParentWidget(
      child: Column(
        children: [
          const CreateAccountFieldsWidget(),
          const SizedBox(height: 16),
          CustomButton(text: 'Create Account', onPressed: () {}),
          const SizedBox(height: 12),
          const OrWidget(),
          const SizedBox(height: 12),
          const RowOFSignInOptionsButtons(),
        ],
      ),
    );
  }
}
