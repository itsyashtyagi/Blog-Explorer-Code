import 'package:blog_explorer/bloc/blogs/blog_bloc.dart';
import 'package:blog_explorer/bloc/blogs/blog_event.dart';
import 'package:blog_explorer/bloc/blogs/blog_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScrrenState();
}

class _HomeScrrenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          switch (state.blogStatus) {
            case BlogStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case BlogStatus.failure:
              return Center(
                child: Text(BlogStatus.failure.toString()),
              );
            case BlogStatus.success:
              return ListView.builder(
                  itemCount: state.blogList.length,
                  itemBuilder: (context, index) {
                    final item = state.blogList[index];
                    return ListTile(
                      title: Text(item.title.toString()),
                    );
                  });
            default:
              return const Center(
                child: Text("No Data To Show"),
              );
          }
        },
      ),
    );
  }
}
