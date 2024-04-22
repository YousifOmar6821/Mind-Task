part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationTimeOut extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String errMsg;

  AuthenticationError(this.errMsg);
}
class LoginSuccess extends AuthenticationState {
  final User user;

  LoginSuccess(this.user);
}

class LoginError extends AuthenticationState {
  final String errMsg;

  LoginError(this.errMsg);
}
