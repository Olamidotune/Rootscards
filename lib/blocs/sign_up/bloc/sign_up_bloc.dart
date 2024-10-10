import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rootscards/repos/repos.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;

  SignUpBloc(this.authRepository) : super(SignUpInitial()) {
    on<CheckSignUpMail>(_checkSignUpMail);
  }

  Future<void> _checkSignUpMail(
      CheckSignUpMail event, Emitter<SignUpState> emit) async {
    emit(CheckSignUpMailLoading());
    try {
      final bool emailExists = await authRepository.checkEmail(
        event.email,
        event.password,
      );
      if (emailExists) {
        emit(CheckSignUpMailSuccess(message: "Email exists"));
      } else {
        emit(CheckSignUpMailFailed("Email does not exist"));
      }
    } catch (e) {
      print(e);
      if (e.toString().contains('Network error') ||
          e.toString().contains('Connection timed out')) {
        emit(CheckSignUpMailError(
            "Network error. Please check your internet connection."));
      } else {
        emit(CheckSignUpMailError("Something went wrong. Please try again."));
      }
    }
  }
}
