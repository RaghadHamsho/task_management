part of 'auth_bloc.dart';


abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String userName;
  final String password;

  LoginEvent({required this.userName, required this.password});
}

class LogoutEvent extends AuthEvent {
  final String? deviceToken;

  LogoutEvent([this.deviceToken]);
}

class SignUPEvent extends AuthEvent {
  final String userName;
  final String password;
  final String email;

  SignUPEvent(
      {required this.userName, required this.password, required this.email});
}