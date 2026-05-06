import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/availability_option_card.dart';
import 'package:flutter/material.dart';

class AvailabilitySelector extends StatelessWidget {
  const AvailabilitySelector({
    super.key,
    required this.selectedDays,
    required this.onSelected,
  });

  final int selectedDays;
  final ValueChanged<int> onSelected;

  static const _options = <int>[2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider2Color),
      ),
      child: Row(
        children: _options
            .map(
              (days) => AvailabilityOptionCard(
                days: days,
                isSelected: selectedDays == days,
                onTap: () => onSelected(days),
              ),
            )
            .toList(),
      ),
    );
  }
}
