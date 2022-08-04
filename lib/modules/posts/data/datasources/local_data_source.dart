import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_clean/core/error/exception.dart';
import 'package:posts_clean/modules/posts/data/models/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/post.dart';

abstract class PostsLocalDataSource {
  Future<Unit> cachePosts(List<PostDTO> posts);
  Future<List<Post>> getPosts();
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<Unit> cachePosts(List<PostDTO> posts) async {
    List<Map<String, dynamic>> postModels =
        posts.map<Map<String, dynamic>>((e) => e.toJson()).toList();

    sharedPreferences.setString("posts", json.encode(postModels));
    return unit;
  }

  @override
  Future<List<Post>> getPosts() async {
    final postsJson = sharedPreferences.getString("posts");
    if (postsJson == null) {
      throw EmptyCacheException();
    } else {
      List decodeJson = json.decode(postsJson);
      List<PostDTO> models =
          decodeJson.map((e) => PostDTO.fromJson(e)).toList();
      return models;
    }
  }
}
