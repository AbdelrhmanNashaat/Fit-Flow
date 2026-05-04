import 'package:fit_flow/features/auth/presentation/views/widgets/auth_container_parent_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/both_text_filed_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/forget_pass_button.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/or_widget.dart';
import 'package:flutter/material.dart';

class MainAuthSection extends StatelessWidget {
  const MainAuthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthContainerParentWidget(
      child: Column(
        children: [
          BothTextFiledWidget(),
          SizedBox(height: 6),
          ForgetPassButton(),
          SizedBox(height: 12),
          OrWidget(),
        ],
      ),
    );
  }
}
