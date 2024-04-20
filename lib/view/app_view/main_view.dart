import 'package:firebase_todo/bloc/ToDoBloc/todo_bloc.dart';
import 'package:firebase_todo/bloc/ToDoBloc/todo_event.dart';
import 'package:firebase_todo/bloc/ToDoBloc/todo_state.dart';
import 'package:firebase_todo/components/const_colors.dart';
import 'package:firebase_todo/model/todo_model.dart';
import 'package:firebase_todo/view/app_view/profile_view.dart';
import 'package:firebase_todo/widget/app_title_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(TodoReadEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Tasks',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfileView()));
            },
            icon: const Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: AppColors.pink,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        if (state is TodoStateLoaded) {
          List<TodoModel> todoList = state.mydata;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) =>
                        AppCard(todoModel: todoList[index]),
                  ),
                ),
              ],
            ),
          );
        } else if (state is TodoStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TodoStateSuccess) {
          return const Center(
            child: Text('Success'),
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('/add');
        },
        foregroundColor: Colors.white,
        backgroundColor: AppColors.pink,
        child: const Icon(Icons.add),
      ),
    );
  }
}
