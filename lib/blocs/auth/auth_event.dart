part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final Promoter? promoter;

  const AuthUserChanged({required this.promoter});
}

class AuthLogoutRequested extends AuthEvent {}

class UserProfileImageChanged extends AuthEvent {
  final String? imgUrl;

  const UserProfileImageChanged({required this.imgUrl});
}
