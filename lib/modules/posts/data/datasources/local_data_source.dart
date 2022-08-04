import 'package:dartz/dartz.dart';
import 'package:posts_clean/modules/posts/data/models/post_model.dart';

import '../../domain/entities/post.dart';

abstract class PostsLocalDataSource {
  Future<Unit> cachePosts(List<PostDTO> posts);
  Future<List<Post>> getPosts();
}

class PostsLocalDataSourceImpl implements PostsLocalDataSource {
  @override
  Future<Unit> cachePosts(List<PostDTO> posts) {
    // TODO: implement cachePosts
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getPosts() {
    // TODO: implement getPosts
    throw UnimplementedError();
  }
}
