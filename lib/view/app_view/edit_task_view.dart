import 'package:firebase_todo/bloc/ToDoBloc/todo_bloc.dart';
import 'package:firebase_todo/bloc/ToDoBloc/todo_event.dart';
import 'package:firebase_todo/components/const_colors.dart';
import 'package:firebase_todo/widget/app_button.dart';
import 'package:firebase_todo/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditTaskView extends StatefulWidget {
  final String? id;
  const EditTaskView({super.key, required this.id});

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){context.goNamed('/home');}, icon: Icon(Icons.arrow_back)),
        title: const Text(
          'Edit Tasks',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.pink,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextField(obscureText: false, controller: _titleController, hintText: "Title"),
              const SizedBox(height: 15,),
              AppTextField(obscureText: false, controller: _descriptionController, hintText: "Description"),
              const SizedBox(height: 15,),
              AppButton(name: "Edit", height: 50,onTap: (){
                BlocProvider.of<TodoBloc>(context).add(TodoEditEvent(_titleController.text, _descriptionController.text, docId: widget.id.toString()));
                context.goNamed('/home');
              },)
            ],
          ),
        ),
      ),
    );
  }
}
