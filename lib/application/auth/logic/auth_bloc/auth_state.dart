part of 'auth_bloc.dart';



enum AuthStatus { initial, loading, success, failure  }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? message;
  final bool isLoading;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.message,
    this.isLoading = false,
  });

  factory AuthState.initial() => const AuthState();

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? message,
    bool? isLoading,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
