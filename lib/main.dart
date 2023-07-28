import 'package:api_requests_with_bloc/features/posts/bloc/posts_bloc.dart';
import 'package:api_requests_with_bloc/features/posts/ui/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostsBloc>(
      create: (context) {
        PostsBloc postsBloc = PostsBloc();
        postsBloc.add(PostsInitialFetchEvent());
        return postsBloc;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(centerTitle: true)),
        home: const PostsPage(),
      ),
    );
  }
}
