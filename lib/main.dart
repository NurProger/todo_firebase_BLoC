import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_todo/bloc/AuthBloc/todo_bloc.dart';
import 'package:firebase_todo/bloc/ToDoBloc/todo_bloc.dart';
import 'package:firebase_todo/firebase_options.dart';
import 'package:firebase_todo/model/todo_model.dart';
import 'package:firebase_todo/repository/services/authentification/firebase_auth.dart';
import 'package:firebase_todo/view/app_view/add_task_view.dart';
import 'package:firebase_todo/view/app_view/edit_task_view.dart';
import 'package:firebase_todo/view/app_view/main_view.dart';
import 'package:firebase_todo/view/app_view/profile_view.dart';
import 'package:firebase_todo/view/app_view/task_details_view.dart';
import 'package:firebase_todo/view/authoritation/sign_in_view.dart';
import 'package:firebase_todo/view/authoritation/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) =>
              AuthBloc(firebaseServices: FirebaseServices()),
        ),
        BlocProvider<TodoBloc>(
          create: (_) => TodoBloc(),
        ),
      ],
      child: const RouterApp(),
    ),
  );
}

final GoRouter _goRoute =
GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/MyApp', routes: <RouteBase>[
  GoRoute(
    name: '/home',
    path: '/home',
    builder: (BuildContext context, GoRouterState state) {
      return const MainView();
    },
  ),
  GoRoute(
    name: '/details',
    path: '/details',
    builder: (BuildContext context, GoRouterState state) {
      final TodoModel todoModel = state.extra as TodoModel;
      return DetailsTaskView(todoModel: todoModel);
    },
  ),
  GoRoute(
      name: '/MyApp',
      path: '/MyApp',
      builder: (BuildContext context, GoRouterState state) {
        return const MyApp();
      }),
  GoRoute(
      name: '/add',
      path: '/add',
      builder: (BuildContext context, GoRouterState state) {
        return const AddTaskView();
      }),
  GoRoute(
      name: '/profile',
      path: '/profile',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileView();
      }),
  GoRoute(
      name: "/edit",
      path: '/edit',
      builder: (BuildContext context, GoRouterState state) {
        final String id = state.extra as String;
        return EditTaskView(
          id: id,
        );
      }),
  GoRoute(
      name: '/signIn',
      path: '/signIn',
      builder: (context, state) {
        return const SignInView();
      }),
  GoRoute(
      name: '/signUp',
      path: '/signUp',
      builder: (context, state) {
        return SignUpView();
      }),
]);
class RouterApp extends StatelessWidget {
  const RouterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _goRoute,
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, state) =>
          MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(create: (BuildContext context) =>
                  AuthBloc(firebaseServices: FirebaseServices())),
              BlocProvider<TodoBloc>(
                  create: (BuildContext context) => TodoBloc())
            ],
            child: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  if (snapshot.data == null) {
                    return const SignInView();
                  } else {
                    return const MainView();
                  }
                }
              },
            ),
          ),
    );
  }
}
