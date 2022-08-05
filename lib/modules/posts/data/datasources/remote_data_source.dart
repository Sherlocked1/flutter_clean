import 'dart:convert';

import 'package:posts_clean/core/error/exception.dart';
import 'package:posts_clean/modules/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostsRemoteDataSource {
  Future<List<PostDTO>> getAllPosts();
  Future<bool> deletePost(int id);
  Future<PostDTO> addPost(PostDTO post);
  Future<PostDTO> updatePost(PostDTO post);
}

class PostsRemoteDataSourceImp implements PostsRemoteDataSource {
  final BASE_URL = "https://jsonplaceholder.typicode.com";
  final BASE_HEADERS = {"Content-Type": "application/json"};

  final http.Client client;

  PostsRemoteDataSourceImp({required this.client});

  @override
  Future<List<PostDTO>> getAllPosts() async {
    try {
      final url = Uri.parse((BASE_URL + "/posts"));
      final response = await client.get(url, headers: BASE_HEADERS);

      if (response.statusCode != 200) {
        throw ServerException();
      } else {
        List jsonResponse = json.decode(response.body) as List;
        final List<PostDTO> posts =
            jsonResponse.map((e) => PostDTO.fromJson(e)).toList();
        return posts;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PostDTO> addPost(PostDTO post) async {
    final body = json.encode({
      "title": post.title,
      "body": post.body,
    });
    final url = Uri.parse(BASE_URL + "/posts");
    try {
      final response =
          await client.post(url, body: body, headers: BASE_HEADERS);

      if (response.statusCode != 201) {
        throw ServerException();
      } else {
        return post;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deletePost(int id) async {
    final url = Uri.parse(BASE_URL + "/posts/${id.toString()}");
    try {
      final response = await client.delete(url, headers: BASE_HEADERS);

      if (response.statusCode != 200) {
        throw ServerException();
      } else {
        return true;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PostDTO> updatePost(PostDTO post) async {
    final body = json.encode({
      "title": post.title,
      "body": post.body,
    });
    final url = Uri.parse(BASE_URL + "/posts/${post.id.toString()}");
    try {
      final response = await client.put(url, body: body, headers: BASE_HEADERS);

      if (response.statusCode != 200) {
        throw ServerException();
      } else {
        return post;
      }
    } catch (e) {
      rethrow;
    }
  }
}
