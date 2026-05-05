import 'package:fit_flow/core/utils/app_assets.dart';
import 'package:fit_flow/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                CustomAppBarWidget(
                  title: 'Home',
                  imagePath: Assets.questionIcon,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
