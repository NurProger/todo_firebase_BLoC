import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_todo/model/todo_model.dart';
import 'package:firebase_todo/repository/helpers/helpers.dart';

class Data {
  final CollectionReference _database =
  FirebaseFirestore.instance.collection('data');
  // save data
  Future<void>saveData(String title, String description) async {
    final email = Helpers.getEmailSharedPreferences();
    try {
       await _database.add({
        "title": title,
        "description": description,
        "email": await email
      });
    } catch (e) {
      print(e);
    }
  }
  // get data
  Future<List<TodoModel>> getData() async {
    final email = await Helpers.getEmailSharedPreferences();
    try{
      final querySnapshot = await _database.where('email', isEqualTo: email).get();
            final userTodo = querySnapshot.docs.map((element) {
              return TodoModel(
                  id: element.id,
                  email: element['email'],
                  description: element['description'],
                  title: element['title']);
            }).toList();
            return userTodo;
    }catch(e){
      throw e;
    }
  }
//update
  Future<void>updateData(String docId,String title, String description)async{
    await _database.doc(docId).update({
      "title": title,
      "description": description,
    });
  }
//delete
  Future<void>deleteData(String docId)async{
    await _database.doc(docId).delete();
  }
}
