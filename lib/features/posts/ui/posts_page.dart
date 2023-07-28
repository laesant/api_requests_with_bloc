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
      floatingActionButton: FloatingActionButton.large(
          onPressed: () => context.read<PostsBloc>().add(PostAddEvent()),
          child: const Icon(Icons.add)),
      body: BlocConsumer<PostsBloc, PostsState>(
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is! PostsActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostsFetchingLoadingState:
              return const Center(child: CircularProgressIndicator());
            case PostFetchingSuccessfulState:
              final successState = state as PostFetchingSuccessfulState;

              return ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    final post = successState.posts[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.grey.shade200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(post.title), Text(post.body)],
                      ),
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
