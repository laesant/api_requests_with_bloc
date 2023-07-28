import 'dart:async';
import 'package:api_requests_with_bloc/features/posts/models/post_data_ui_model.dart';
import 'package:api_requests_with_bloc/features/posts/repos/posts_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitialState()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());
    List<PostDataUiModel> posts = await PostsRepo.fetchPosts();

    emit(PostFetchingSuccessfulState(posts: posts));
  }

  FutureOr<void> postAddEvent(
      PostAddEvent event, Emitter<PostsState> emit) async {
    bool success = await PostsRepo.addPost();
    if (success) {
      emit(PostAdditionalSuccessState());
    } else {
      emit(PostAdditionalErrorState());
    }
  }
}
