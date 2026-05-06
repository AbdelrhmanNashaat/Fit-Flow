import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/reset_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._authRepo) : super(const ResetPasswordInitial());

  final AuthRepo _authRepo;

  Future<void> resetPassword(String email) async {
    emit(const ResetPasswordLoading());
    final result = await _authRepo.resetPassword(email);
    result.fold(
      (failure) => emit(ResetPasswordFailure(failure.message)),
      (_) => emit(const ResetPasswordSuccess()),
    );
  }

  void clearError() => emit(const ResetPasswordInitial());
}
