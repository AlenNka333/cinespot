import 'package:cinespot/data/managers/authentication_manager.dart';
import 'package:cinespot/data/services/global_error_handler_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationManager _authManager;
  bool isPasswordVisible = false;

  LoginBloc(this._authManager) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLogin);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  Future<void> _onLogin(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      await _authManager.login(
        username: event.username,
        password: event.password,
      );
      emit(LoginSuccess());
    } catch (error) {
      GlobalErrorHandlerService().show(error.toString());
      emit(LoginFailed(error.toString()));
    }
  }

  void _onTogglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<LoginState> emit) {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityChanged(isPasswordVisible));
  }
}
