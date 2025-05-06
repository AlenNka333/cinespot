enum SplashStatus { loading, authorized, unauthorized }

class SplashState {
  final SplashStatus status;

  const SplashState({required this.status});

  factory SplashState.initial() =>
      const SplashState(status: SplashStatus.loading);

  SplashState copyWith({
    SplashStatus? status,
  }) {
    return SplashState(status: status ?? this.status);
  }
}
