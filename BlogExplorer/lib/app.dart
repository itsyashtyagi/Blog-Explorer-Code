import 'package:blog_explorer/bloc/blogs/blog_bloc.dart';
import 'package:blog_explorer/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => BlogBloc())],
      child: const MaterialApp(
        title: 'Blog Explorer',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
