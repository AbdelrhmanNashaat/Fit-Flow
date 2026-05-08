import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/features/auth/data/model/auth_user.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/reset_password_state.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_in_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_in_state.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_up_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late AuthRepo authRepo;

  const testUser = AuthUser(
    id: 'user-1',
    name: 'Abdelrhman',
    email: 'abdelrhman@example.com',
  );

  setUp(() {
    authRepo = _MockAuthRepo();
  });

  group('SignInCubit', () {
    blocTest<SignInCubit, SignInState>(
      'emits field failure when backend returns email-scoped auth failure',
      build: () {
        when(
          () => authRepo.signIn('bad@example.com', 'password123'),
        ).thenAnswer(
          (_) async => const Left(
            AuthFailure(
              message: 'No user found with this email.',
              code: AuthErrorCode.userNotFound,
              field: FailureField.email,
            ),
          ),
        );

        return SignInCubit(authRepo);
      },
      act: (cubit) => cubit.signIn('bad@example.com', 'password123'),
      expect: () => [
        isA<SignInLoading>(),
        isA<SignInFieldFailure>().having(
          (state) => state.emailError,
          'emailError',
          'No user found with this email.',
        ),
      ],
    );

    blocTest<SignInCubit, SignInState>(
      'returns to initial state when Google sign-in is cancelled',
      build: () {
        when(() => authRepo.signInWithGoogle()).thenAnswer(
          (_) async => const Left(
            AuthFailure(
              message: 'Google sign-in was cancelled.',
              code: AuthErrorCode.cancelled,
              field: FailureField.general,
            ),
          ),
        );

        return SignInCubit(authRepo);
      },
      act: (cubit) => cubit.signInWithGoogle(),
      expect: () => [
        isA<SignInLoading>().having(
          (state) => state.isGoogle,
          'isGoogle',
          true,
        ),
        isA<SignInInitial>(),
      ],
    );

    blocTest<SignInCubit, SignInState>(
      'emits success for valid credentials',
      build: () {
        when(
          () => authRepo.signIn('abdelrhman@example.com', 'password123'),
        ).thenAnswer((_) async => const Right(testUser));

        return SignInCubit(authRepo);
      },
      act: (cubit) => cubit.signIn('abdelrhman@example.com', 'password123'),
      expect: () => [isA<SignInLoading>(), isA<SignInSuccess>()],
    );
  });

  group('SignUpCubit', () {
    blocTest<SignUpCubit, SignUpState>(
      'emits password field failure when backend rejects weak password',
      build: () {
        when(
          () =>
              authRepo.signUp('Abdelrhman', 'abdelrhman@example.com', '123456'),
        ).thenAnswer(
          (_) async => const Left(
            AuthFailure(
              message: 'The password is too weak.',
              code: AuthErrorCode.weakPassword,
              field: FailureField.password,
            ),
          ),
        );

        return SignUpCubit(authRepo);
      },
      act: (cubit) =>
          cubit.signUp('Abdelrhman', 'abdelrhman@example.com', '123456'),
      expect: () => [
        isA<SignUpLoading>(),
        isA<SignUpFieldFailure>().having(
          (state) => state.passwordError,
          'passwordError',
          'The password is too weak.',
        ),
      ],
    );

    blocTest<SignUpCubit, SignUpState>(
      'passes trimmed name to repo and emits success',
      build: () {
        when(
          () => authRepo.signUp(
            'Abdelrhman',
            'abdelrhman@example.com',
            'password123',
          ),
        ).thenAnswer((_) async => const Right(testUser));

        return SignUpCubit(authRepo);
      },
      act: (cubit) =>
          cubit.signUp(' Abdelrhman ', 'abdelrhman@example.com', 'password123'),
      expect: () => [isA<SignUpLoading>(), isA<SignUpSuccess>()],
      verify: (_) {
        verify(
          () => authRepo.signUp(
            'Abdelrhman',
            'abdelrhman@example.com',
            'password123',
          ),
        ).called(1);
      },
    );
  });

  group('ResetPasswordCubit', () {
    blocTest<ResetPasswordCubit, ResetPasswordState>(
      'emits field failure when backend returns email validation failure',
      build: () {
        when(() => authRepo.resetPassword('bad@example.com')).thenAnswer(
          (_) async => const Left(
            AuthFailure(
              message: 'The email address is invalid.',
              code: AuthErrorCode.invalidEmail,
              field: FailureField.email,
            ),
          ),
        );

        return ResetPasswordCubit(authRepo);
      },
      act: (cubit) => cubit.resetPassword('bad@example.com'),
      expect: () => [
        isA<ResetPasswordLoading>(),
        isA<ResetPasswordFieldFailure>().having(
          (state) => state.emailError,
          'emailError',
          'The email address is invalid.',
        ),
      ],
    );

    blocTest<ResetPasswordCubit, ResetPasswordState>(
      'emits success when reset email is accepted',
      build: () {
        when(
          () => authRepo.resetPassword('abdelrhman@example.com'),
        ).thenAnswer((_) async => const Right(null));

        return ResetPasswordCubit(authRepo);
      },
      act: (cubit) => cubit.resetPassword('abdelrhman@example.com'),
      expect: () => [isA<ResetPasswordLoading>(), isA<ResetPasswordSuccess>()],
    );
  });
}
