import 'package:posts_clean/modules/posts/data/models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostDTO>> getAllPosts();
  Future<bool> deletePost(int id);
  Future<PostDTO> addPost(PostDTO post);
  Future<PostDTO> updatePost(PostDTO post);
}

class PostsRemoteDataSourceImp implements PostsRemoteDataSource {
  @override
  Future<List<PostDTO>> getAllPosts() async {
    return [];
  }

  @override
  Future<PostDTO> addPost(PostDTO post) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> deletePost(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<PostDTO> updatePost(PostDTO post) async {
    throw UnimplementedError();
  }
}
