import 'package:firebase_todo/bloc/ToDoBloc/todo_event.dart';
import 'package:firebase_todo/bloc/ToDoBloc/todo_state.dart';
import 'package:firebase_todo/repository/services/todo_services/crud_todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoStateInit()) {
    on<TodoAddedEvent>((event, emit) async {
      emit(TodoStateLoading());
      try {
        await _data.saveData(event.title,event.description);
      } catch (e) {
        emit(TodoStateError(errorText: e.toString()));
      }
    });
    on<TodoReadEvent>((event, emit)async{
      emit(TodoStateLoading());
      try{
        final data = await _data.getData();
        if(data == null){
          emit(TodoStateError(errorText: "Failed to getting data"));
        }else{
          emit(TodoStateLoaded(mydata: data));
        }
      }catch(e){
        emit(TodoStateError(errorText: e.toString()));
      }
    });
    on<TodoDeleteEvent>((event, emit)async{
      emit(TodoStateLoading());
      try{
        await _data.deleteData(event.docId);
      }catch(e){
        emit(TodoStateError(errorText: e.toString()));
      }
    });
    on<TodoEditEvent>((event, emit)async{
      emit(TodoStateLoading());
      try{
        await _data.updateData(event.docId, event.title, event.description);
      }catch(e){
        emit(TodoStateError(errorText: e.toString()));
      }
    });
  }
  final Data _data = Data();
}
