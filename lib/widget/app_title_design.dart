import 'package:firebase_todo/bloc/ToDoBloc/todo_bloc.dart';
import 'package:firebase_todo/bloc/ToDoBloc/todo_event.dart';
import 'package:firebase_todo/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppCard extends StatefulWidget {
  const AppCard(
      {super.key, required this.todoModel});


  final TodoModel todoModel;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() => context.goNamed('/details',extra: widget.todoModel),
      child: Card(
        color: const Color.fromARGB(255, 234, 46, 98),
        child: ListTile(
          title: Text(widget.todoModel.title,style: const TextStyle(color: Colors.white),),
          subtitle: Text(
            widget.todoModel.description,style: const TextStyle(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing:
          SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(onPressed: () {
                  context.goNamed('/edit',extra: widget.todoModel.id);
                }, icon: const Icon(Icons.edit,color: Colors.white,)),
                IconButton(onPressed: (){
                  BlocProvider.of<TodoBloc>(context).add(TodoDeleteEvent(docId: widget.todoModel.id.toString()));
                }, icon: const Icon(Icons.delete,color: Colors.white,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
