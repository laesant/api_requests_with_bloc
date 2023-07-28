import 'package:api_requests_with_bloc/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página de Postagens"),
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostFetchingSuccessfulState:
              final successState = state as PostFetchingSuccessfulState;

              return ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    final post = successState.posts[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(post.title)],
                    );
                  });
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}