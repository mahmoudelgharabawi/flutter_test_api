import 'dart:convert';

import 'package:json_api_example/models/comment.dart';
import 'package:json_api_example/models/post.dart';
import 'package:http/http.dart' as http;

class AppContrloller {
  static Future<List<Post>> getPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    return List<Post>.from(
        jsonDecode(response.body).map((e) => Post.fromJson(e)));
  }

  static Future createPost({required Map<String, dynamic> body}) async {
    return http.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        body: jsonEncode(body),
        headers: {'Content-type': 'application/json'}).then((value) {
      final statusCode = value.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw Exception('Error Sending Data To API');
      }
      print(value.statusCode);
      print(value.body);
    });
  }

  static Future<List<Comment>> getComments({required int postId}) async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/comments?postId=$postId'));

    return List<Comment>.from(
        jsonDecode(response.body).map((e) => Comment.fromJson(e)));
  }
}
