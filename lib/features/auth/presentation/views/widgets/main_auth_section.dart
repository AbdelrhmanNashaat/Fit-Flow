import 'package:fit_flow/core/widgets/custom_button.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/auth_container_parent_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/both_text_filed_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/forget_pass_button.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/or_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/row_oF_sign_in_options_buttons.dart';
import 'package:flutter/material.dart';

class MainAuthSection extends StatelessWidget {
  const MainAuthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthContainerParentWidget(
      child: Column(
        children: [
          const BothTextFiledWidget(),
          const SizedBox(height: 6),
          const ForgetPassButton(),
          const SizedBox(height: 12),
          CustomButton(
            text: 'Continue',
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          const OrWidget(),
          const SizedBox(height: 12),
          const RowOFSignInOptionsButtons(),
        ],
      ),
    );
  }
}
