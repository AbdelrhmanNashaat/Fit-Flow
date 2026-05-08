import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileLegalSection extends StatelessWidget {
  const ProfileLegalSection({super.key});

  static const _privacyUrl = 'https://fitflow.app/privacy';
  static const _termsUrl = 'https://fitflow.app/terms';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LegalTile(
            label: l10n.privacyPolicy,
            onTap: () => _launchUrl(_privacyUrl),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.dividerLight,
            indent: 16,
            endIndent: 16,
          ),
          _LegalTile(
            label: l10n.termsOfService,
            onTap: () => _launchUrl(_termsUrl),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _LegalTile extends StatelessWidget {
  const _LegalTile({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(child: Text(label, style: AppTextStyles.regular14.copyWith(color: AppColors.textSecondary))),
              const Icon(
                Icons.open_in_new_rounded,
                size: 20,
                color: AppColors.orTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
