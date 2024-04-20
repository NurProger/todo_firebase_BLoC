
import 'package:firebase_todo/components/const_colors.dart';
import 'package:firebase_todo/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsTaskView extends StatelessWidget {
  const DetailsTaskView({super.key, required this.todoModel});

  final TodoModel todoModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){context.goNamed('/home');}, icon: const Icon(Icons.arrow_back)),
        backgroundColor: AppColors.pink,
        foregroundColor: Colors.white,
        title: const Text('Details',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.pink,
              ),
            ),
            Text(
              todoModel.title,
              style: const TextStyle(fontSize: 20),
            ),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColors.pink,
              ),
            ),
            Text(
              todoModel.description,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
