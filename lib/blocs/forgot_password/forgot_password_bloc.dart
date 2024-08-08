import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rootscards/repos/repos.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepository authRepository;

  ForgotPasswordBloc(this.authRepository) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEmailEvent>(_forgotPasswordEmailEvent);
  }

  FutureOr<void> _forgotPasswordEmailEvent(
      ForgotPasswordEmailEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoadingState());
    try {
      final success = await authRepository.resetPassword(event.email);
      if (success) {
        emit(ForgotPasswordSuccessState(
            message: "We sent a link to your email."));
      } else {
        emit(
          ForgotPasswordErrorState(
            errorMessage: "The provided email isn't found on our server",
          ),
        );
      }
    } catch (e) {
      emit(
        ForgotPasswordFailedState(
          message: "Something went wrong",
        ),
      );
    }
  }
}
