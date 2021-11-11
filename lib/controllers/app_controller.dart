import 'dart:convert';

import 'package:json_api_example/models/post.dart';
import 'package:http/http.dart' as http;

class AppContrloller {
  static Future<List<Post>> getPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    return List<Post>.from(
        jsonDecode(response.body).map((e) => Post.fromJson(e)));
  }
}
