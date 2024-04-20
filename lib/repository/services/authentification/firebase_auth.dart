import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo/repository/helpers/helpers.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  // sign up
  Future<User?> createUserWithEmailAndPassword(
      String email, String password, String name, String surname) async {
    final user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _users.add({'email': email, 'name': name, 'surname': surname}).then(
        (value) => print("Success"));
    Helpers.saveEmailSharedPreferences(email);
    Helpers.saveNameSharedPreferences(name);
    Helpers.saveSurnameSharedPreferences(surname);
    Helpers.saveIsLoggedSharedPreferences(true);
    return user.user;
  }
  // sign in
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    _users.where('email',isEqualTo: email).get().then((value) => {
      value.docs.forEach((element) {
        Helpers.saveEmailSharedPreferences(element['email']);
        Helpers.saveNameSharedPreferences(element['name']);
        Helpers.saveSurnameSharedPreferences(element['surname']);
        Helpers.saveIsLoggedSharedPreferences(true);
      })
    });
    return user.user;
  }
  //sign out
  Future<void>signOut()async{
    await _auth.signOut();
    Helpers.removeEmailSharedPreferences();
    Helpers.removeIsLoggedSharedPreferences();
    Helpers.removeNameSharedPreferences();
    Helpers.removeSurnameSharedPreferences();
  }

}
