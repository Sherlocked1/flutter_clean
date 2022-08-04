import 'package:dartz/dartz.dart';
import 'package:posts_clean/core/error/failures.dart';
import '../repositories/posts_repositories.dart';

import '../entities/post.dart';

class UpdatePost {
  final PostsRepository repository;

  UpdatePost(this.repository);

  Future<Either<Post, Failure>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
