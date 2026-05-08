import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartingWeightDialog extends StatefulWidget {
  const StartingWeightDialog({super.key, this.initialWeight});

  final double? initialWeight;

  /// Returns the entered weight, or null if the user tapped "Use default".
  static Future<double?> show(
    BuildContext context, {
    double? initialWeight,
  }) {
    return showDialog<double>(
      context: context,
      barrierDismissible: false,
      builder: (_) => StartingWeightDialog(initialWeight: initialWeight),
    );
  }

  @override
  State<StartingWeightDialog> createState() => _StartingWeightDialogState();
}

class _StartingWeightDialogState extends State<StartingWeightDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialWeight != null
          ? widget.initialWeight!.toStringAsFixed(
              widget.initialWeight! % 1 == 0 ? 0 : 1,
            )
          : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: AppColors.whiteColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.startingWeight,
              style: AppTextStyles.bold18.copyWith(color: AppColors.blackColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.startingWeightSubtitle,
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.orTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Weight input
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundScaffold,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.dividerLight),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d*'),
                        ),
                      ],
                      textAlign: TextAlign.center,
                      style: AppTextStyles.extraBold26.copyWith(fontSize: 32),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 16),
                    child: Text(
                      l10n.kg,
                      style: AppTextStyles.bold16.copyWith(
                        color: AppColors.orTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final value = double.tryParse(_controller.text.trim());
                  if (value != null && value >= 1.0) {
                    Navigator.of(context).pop(value);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  l10n.saveAndStart,
                  style: AppTextStyles.bold16.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(null),
              child: Text(
                l10n.useDefault,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.orTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
