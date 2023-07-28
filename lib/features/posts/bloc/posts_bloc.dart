import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:api_requests_with_bloc/features/posts/models/post_data_ui_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitialState()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      List<dynamic> body = json.decode(response.body);
      for (Map<String, dynamic> map in body) {
        posts.add(PostDataUiModel.fromMap(map));
      }
      emit(PostFetchingSuccessfulState(posts: posts));
      print(posts);
    } catch (e) {
      log(e.toString());
    } finally {
      client.close();
    }
  }
}
