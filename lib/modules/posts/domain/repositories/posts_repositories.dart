import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

abstract class PostsRepository {
  Future<Either<List<Post>, Failure>> getAllPosts();
  Future<Either<bool, Failure>> deletePost(int id);
  Future<Either<Post, Failure>> updatePost(Post newPost);
  Future<Either<Post, Failure>> addPost(Post newPost);
}
