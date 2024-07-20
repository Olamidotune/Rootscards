// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rootscards/repos/repos.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpAuthBloc extends Bloc<OtpAuthEvent, OtpAuthState> {
  final AuthRepository authRepository;

  OtpAuthBloc(this.authRepository) : super(OtpInitial()) {
    on<DeviceAuthenticationRequested>(_onDeviceAuthenticationRequested);
  }

  Future<void> _onDeviceAuthenticationRequested(
    DeviceAuthenticationRequested event,
    Emitter<OtpAuthState> emit,
  ) async {
    emit(OtpLoadingState());
    try {
      final result = await authRepository.authenticateDevice(event.otp);
      final authId = await authRepository.getAuthId();
      if (authId != null) {
        emit(DeviceAuthenticationSuccess(authId));
      } else {
        emit(OtpFailedState('Failed to retrieve authId'));
      }
    } catch (e) {
      emit(OtpFailedState(e.toString()));
    }
  }
}
