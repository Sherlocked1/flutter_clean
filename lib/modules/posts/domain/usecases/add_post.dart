import 'package:dartz/dartz.dart';
import 'package:posts_clean/core/error/failures.dart';

import '../entities/post.dart';
import '../repositories/posts_repositories.dart';

class AddPost {
  final PostsRepository repository;

  AddPost(this.repository);

  Future<Either<Post, Failure>> call(Post post) async {
    return await repository.addPost(post);
  }
}
