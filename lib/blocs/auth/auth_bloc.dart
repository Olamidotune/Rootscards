import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rootscards/blocs/auth/auth_event.dart';
import 'package:rootscards/blocs/auth/auth_state.dart';
import 'package:rootscards/repos/repos.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
  LoginRequested event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoading());
  try {
    final result = await authRepository.login(event.email, event.password);
    final needsDeviceAuth = result['status'] == '201';
    emit(AuthSuccess(needsDeviceAuth: needsDeviceAuth));
  } catch (e) {
    if (e.toString().contains('Incorrect credentials')) {
      emit(AuthFailure('Incorrect credentials'));
    } else {
      emit(AuthError(error: 'Something went wrong'));
    }
  }
}

}
