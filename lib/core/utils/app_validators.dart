import 'package:fit_flow/generated/l10n.dart';

class AppValidators {
  static String? validateEmail(String? value, S l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.emailRequiredError;
    }
    final emailRegex = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return l10n.emailInvalidError;
    }
    return null;
  }

  static String? validatePassword(String? value, S l10n) {
    if (value == null || value.isEmpty) {
      return l10n.passwordRequiredError;
    }
    if (value.length < 8) {
      return l10n.passwordTooShortError;
    }
    return null;
  }

  static String? validateName(String? value, S l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.fullNameRequiredError;
    }
    if (value.trim().length < 2) {
      return l10n.fullNameTooShortError;
    }
    return null;
  }

  static String? Function(String?) confirmPasswordValidator(
    String password,
    S l10n,
  ) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return l10n.confirmPasswordRequiredError;
      }
      if (value != password) {
        return l10n.passwordsDoNotMatchError;
      }
      return null;
    };
  }
}
