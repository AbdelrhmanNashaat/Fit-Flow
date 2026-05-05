import 'package:fit_flow/features/auth/data/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/reset_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._authRepo) : super(ResetPasswordInitial());

  final AuthRepo _authRepo;

  Future<void> resetPassword(String email) async {
    emit(ResetPasswordLoading());
    final result = await _authRepo.resetPassword(email);
    result.fold(
      (failure) => emit(ResetPasswordFailure(failure.message)),
      (_) => emit(ResetPasswordSuccess()),
    );
  }
}
