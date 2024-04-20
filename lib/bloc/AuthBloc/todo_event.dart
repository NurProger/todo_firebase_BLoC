abstract class AuthEvent {}

class SignInAuthEvent extends AuthEvent {
  String email;
  String password;


  SignInAuthEvent(
      {required this.email,
      required this.password,
      });
}
class SignUpAuthEvent extends AuthEvent {
  String email;
  String password;
  String name;
  String surname;

  SignUpAuthEvent(
      {required this.email,
        required this.password,
        required this.surname,
        required this.name});
}
class SignOutAuthEvent extends AuthEvent{}
class UserLogged extends AuthEvent {}