import 'package:firebase_todo/bloc/ToDoBloc/todo_bloc.dart';
import 'package:firebase_todo/bloc/ToDoBloc/todo_event.dart';
import 'package:firebase_todo/bloc/ToDoBloc/todo_state.dart';
import 'package:firebase_todo/components/const_colors.dart';
import 'package:firebase_todo/widget/app_button.dart';
import 'package:firebase_todo/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){context.goNamed('/home');}, icon: Icon(Icons.arrow_back)),
          title: const Text(
            'Add Tasks',
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
                AppTextField(
                    obscureText: false,
                    controller: _titleController,
                    hintText: "Title"),
                const SizedBox(
                  height: 15,
                ),
                AppTextField(
                    obscureText: false,
                    controller: _descriptionController,
                    hintText: "Description"),
                const SizedBox(
                  height: 15,
                ),
                AppButton(
                  name: "Add",
                  height: 50,
                  onTap: () {
                    if (_descriptionController.text == "" ||
                        _titleController.text == "") {
                      context.goNamed('/home');
                    } else {
                      BlocProvider.of<TodoBloc>(context).add(
                        TodoAddedEvent(
                            title: _titleController.text,
                            description: _descriptionController.text),
                      );
                      context.goNamed('/home');
                    }
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
