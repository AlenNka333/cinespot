part of 'splash_bloc.dart';

class SplashState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class AuthorizationProcessing extends SplashState {}

class Authorized extends SplashState {}

class Unauthorized extends SplashState {}

class AuthorizationStatusFailed extends SplashState {
  final String error;
  AuthorizationStatusFailed(this.error);
  @override
  List<Object?> get props => [error];
}
