import 'dart:convert';

class PostDataUiModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostDataUiModel(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  Map<String, dynamic> toMap() =>
      {'userId': userId, 'id': id, 'title': title, 'body': body};

  factory PostDataUiModel.fromMap(Map<String, dynamic> map) => PostDataUiModel(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      body: map['body']);

  String toJson() => json.encode(toMap());

  factory PostDataUiModel.fromJson(String source) =>
      PostDataUiModel.fromMap(json.decode(source));
}
