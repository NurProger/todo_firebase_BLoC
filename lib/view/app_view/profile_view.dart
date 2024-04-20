import 'package:firebase_todo/bloc/AuthBloc/todo_bloc.dart';
import 'package:firebase_todo/bloc/AuthBloc/todo_event.dart';
import 'package:firebase_todo/bloc/AuthBloc/todo_state.dart';
import 'package:firebase_todo/components/const_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(UserLogged());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){context.goNamed('/home');}, icon: Icon(Icons.arrow_back)),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutAuthEvent());
              context.goNamed('/MyApp');
            },
            icon: const Icon(
              Icons.login,
              color: Colors.white,
              size: 28,
            ),
          ),
        ],
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.pink,
      ),
      body: Center(
        child: BlocBuilder<AuthBloc,AuthState>(
          builder: (BuildContext context,state) {
            if(state is AuthSuccess){
              final user = state.userData;
              return Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(child: Icon(Icons.account_circle_rounded,size: 150,),),
                    const SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Name',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: AppColors.pink, ),),
                        Text(user.name,style: const TextStyle(fontSize: 25)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('surname',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: AppColors.pink, ),),
                        Text(user.surname,style: const TextStyle(fontSize: 25)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('email',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: AppColors.pink, ),),
                        Text(user.email,style: const TextStyle(fontSize: 25)),
                      ],
                    ),
                  ],
                ),
              );
            }else if(state is AuthError ){
              return const Center(child: Text('Error'),);
            }else if(state is AuthInit){
              return const Center(child: Text('Init'),);
            }else{
              return const Center(child: Text('Loading'),);
            }
          }
        ),
      ),
    );
  }
}
