import 'package:firebase_todo/model/user_model.dart';

abstract class AuthState {}
class AuthInit extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final UserModel userData;
  AuthSuccess({required this.userData});
}
class AuthError extends AuthState {
  final String errorText;
  AuthError({required this.errorText});
}
