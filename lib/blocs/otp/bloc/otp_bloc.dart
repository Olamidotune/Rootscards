import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rootscards/services/auth_services.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpAuthBloc extends Bloc<OtpAuthEvent, OtpAuthState> {
  final AuthServices authServices;

  OtpAuthBloc(this.authServices) : super(OtpInitial()) {
    on<AuthorizeDeviceEvent>(_otpAuthEvent);
  }

  FutureOr<void> _otpAuthEvent(
      AuthorizeDeviceEvent event, Emitter<OtpAuthState> emit) async {
    emit(OtpLoadingState());
    try {
      final response = await authServices.authOtp(event.otp);
      emit(OtpSuccessState(response['data']['authid']));
    } catch (e) {
      emit(OtpFailedState(e.toString()));
    }
  }
}
