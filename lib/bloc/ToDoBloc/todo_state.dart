import 'package:firebase_todo/model/todo_model.dart';

abstract class TodoState {}
class TodoStateInit extends TodoState{}
class TodoStateLoading extends TodoState{}
class TodoStateSuccess extends TodoState{}
class TodoStateError extends TodoState{
  final String errorText;
  TodoStateError({required this.errorText});
}
class TodoStateLoaded extends TodoState{
  List<TodoModel> mydata;
  TodoStateLoaded({required this.mydata});

  List<Object?>get props => [mydata];
}