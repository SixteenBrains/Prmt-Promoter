part of 'auth_bloc.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthState extends Equatable {
  final Promoter? promoter;
  final AuthStatus status;

  const AuthState({
    this.promoter,
    this.status = AuthStatus.unknown,
  });

  factory AuthState.unknown() => const AuthState();

  factory AuthState.authenticated({required Promoter? promoter}) =>
      AuthState(promoter: promoter, status: AuthStatus.authenticated);

  factory AuthState.unAuthenticated() =>
      const AuthState(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [promoter, status];

  @override
  bool? get stringify => true;

  AuthState copyWith({
    Promoter? promoter,
    AuthStatus? status,
  }) {
    return AuthState(
      promoter: promoter ?? this.promoter,
      status: status ?? this.status,
    );
  }
}
