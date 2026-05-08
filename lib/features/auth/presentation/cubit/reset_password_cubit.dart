import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/reset_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._authRepo) : super(const ResetPasswordInitial());

  final AuthRepo _authRepo;

  Future<void> resetPassword(String email) async {
    emit(const ResetPasswordLoading());
    final result = await _authRepo.resetPassword(email);
    result.fold(_emitFailure, (_) => emit(const ResetPasswordSuccess()));
  }

  void clearError() => emit(const ResetPasswordInitial());

  void _emitFailure(Failure failure) {
    if (failure case AuthFailure(field: FailureField.email, :final message)) {
      emit(ResetPasswordFieldFailure(emailError: message));
      return;
    }

    emit(ResetPasswordFailure(failure.message));
  }
}
