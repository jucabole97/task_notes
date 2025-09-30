sealed class SplashState {
  const SplashState();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashLoaded extends SplashState {
  const SplashLoaded();
}

class SplashError extends SplashState {
  final String message;
  const SplashError(this.message);
}
