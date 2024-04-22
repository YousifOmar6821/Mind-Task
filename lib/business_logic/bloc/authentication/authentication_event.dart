part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class Login extends AuthenticationEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});
}
