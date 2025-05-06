part of 'login_bloc.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailed extends LoginState {
  final String error;
  LoginFailed(this.error);
  @override
  List<Object?> get props => [error];
}

class PasswordVisibilityChanged extends LoginState {
  final bool isVisible;
  PasswordVisibilityChanged(this.isVisible);

  @override
  List<Object?> get props => [isVisible];
}
