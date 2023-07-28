import 'dart:convert';
import 'dart:developer';

import 'package:api_requests_with_bloc/features/posts/models/post_data_ui_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostDataUiModel>> fetchPosts() async {
    var client = http.Client();
    List<PostDataUiModel> posts = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      List<dynamic> body = json.decode(response.body);
      for (Map<String, dynamic> map in body) {
        posts.add(PostDataUiModel.fromMap(map));
      }
      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<bool> addPost() async {
    var client = http.Client();
    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        "title": "Laenio é muito bonito",
        "body":
            "Realmente nunca vai existe alguem mais lindo que esse hoemem em toda a existencia da humanidade humana!",
        "userId": "7"
      });

      if (response.statusCode >= 200 && response.statusCode <= 300) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
