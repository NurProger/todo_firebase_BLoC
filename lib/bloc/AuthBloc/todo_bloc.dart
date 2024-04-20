import 'package:firebase_todo/bloc/AuthBloc/todo_event.dart';
import 'package:firebase_todo/bloc/AuthBloc/todo_state.dart';
import 'package:firebase_todo/model/user_model.dart';
import 'package:firebase_todo/repository/helpers/helpers.dart';
import 'package:firebase_todo/repository/services/authentification/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.firebaseServices}) : super(AuthInit()) {
    on<SignUpAuthEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await firebaseServices.createUserWithEmailAndPassword(
            event.email, event.password, event.name, event.surname);
      } catch (e) {
        AuthError(errorText: e.toString());
      }
    });
    on<SignInAuthEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await firebaseServices.signInWithEmailAndPassword(
            event.email, event.password);
      } catch (e) {
        AuthError(errorText: e.toString());
      }
    });
    on<SignOutAuthEvent>((event, emit) async {
      await firebaseServices.signOut();
    });
    on<UserLogged>((event, emit) async {
      final name = await Helpers.getNameSharedPreferences();
      final surname = await Helpers.getSurnameSharedPreferences();
      final email = await Helpers.getEmailSharedPreferences();
      try {
        final userData = UserModel(name: name, email: email, surname: surname);
        emit(AuthSuccess(userData: userData));
      } catch (e) {
        AuthError(errorText: e.toString());
      }
    });
  }

  final FirebaseServices firebaseServices;
}
