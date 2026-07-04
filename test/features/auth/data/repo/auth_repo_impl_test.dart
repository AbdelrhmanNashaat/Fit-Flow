import 'package:fit_flow/core/utils/app_validators.dart';
import 'package:fit_flow/generated/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockS extends Mock implements S {
  @override
  String get fullNameRequiredError => 'name required';
  @override
  String get fullNameTooShortError => 'name too short';
  @override
  String get emailRequiredError => 'email required';
  @override
  String get emailInvalidError => 'email invalid';
  @override
  String get passwordRequiredError => 'password required';
  @override
  String get passwordTooShortError => 'password too short';
  @override
  String get confirmPasswordRequiredError => 'confirm password required';
  @override
  String get passwordsDoNotMatchError => 'passwords do not match';
}

void main() {
  final l10n = _MockS();

  group('validateName', () {
    test('returns error when name is null', () {
      expect(AppValidators.validateName(null, l10n), isNotNull);
    });

    test('returns error when name is empty', () {
      expect(AppValidators.validateName('', l10n), isNotNull);
    });

    test('returns error when name is only whitespace', () {
      expect(AppValidators.validateName('   ', l10n), isNotNull);
    });

    test('returns error when name is less than 2 characters', () {
      expect(AppValidators.validateName('A', l10n), isNotNull);
    });

    test('returns null when name is valid', () {
      expect(AppValidators.validateName('Ab', l10n), isNull);
    });

    test('returns null when name is long', () {
      expect(AppValidators.validateName('John Doe', l10n), isNull);
    });
  });

  group('validateEmail', () {
    test('returns error when email is null', () {
      expect(AppValidators.validateEmail(null, l10n), isNotNull);
    });

    test('returns error when email is empty', () {
      expect(AppValidators.validateEmail('', l10n), isNotNull);
    });

    test('returns error when email is only whitespace', () {
      expect(AppValidators.validateEmail('   ', l10n), isNotNull);
    });

    test('returns error when email has no @', () {
      expect(AppValidators.validateEmail('testgmail.com', l10n), isNotNull);
    });

    test('returns error when email has no domain', () {
      expect(AppValidators.validateEmail('test@', l10n), isNotNull);
    });

    test('returns error when email domain has no TLD', () {
      expect(AppValidators.validateEmail('test@gmail', l10n), isNotNull);
    });

    test('returns null when email is valid', () {
      expect(AppValidators.validateEmail('test@gmail.com', l10n), isNull);
    });

    test('returns null when email has subdomain', () {
      expect(AppValidators.validateEmail('user@mail.co.uk', l10n), isNull);
    });
  });

  group('validatePassword', () {
    test('returns error when password is null', () {
      expect(AppValidators.validatePassword(null, l10n), isNotNull);
    });

    test('returns error when password is empty', () {
      expect(AppValidators.validatePassword('', l10n), isNotNull);
    });

    test('returns error when password is less than 8 characters', () {
      expect(AppValidators.validatePassword('1234567', l10n), isNotNull);
    });

    test('returns null when password is exactly 8 characters', () {
      expect(AppValidators.validatePassword('12345678', l10n), isNull);
    });

    test('returns null when password is longer than 8 characters', () {
      expect(AppValidators.validatePassword('longpassword123', l10n), isNull);
    });
  });

  group('confirmPasswordValidator', () {
    const password = 'mypassword123';

    test('returns error when confirm password is null', () {
      final validator = AppValidators.confirmPasswordValidator(password, l10n);
      expect(validator(null), isNotNull);
    });

    test('returns error when confirm password is empty', () {
      final validator = AppValidators.confirmPasswordValidator(password, l10n);
      expect(validator(''), isNotNull);
    });

    test('returns error when passwords do not match', () {
      final validator = AppValidators.confirmPasswordValidator(password, l10n);
      expect(validator('differentpassword'), isNotNull);
    });

    test('returns null when passwords match', () {
      final validator = AppValidators.confirmPasswordValidator(password, l10n);
      expect(validator(password), isNull);
    });
  });
}