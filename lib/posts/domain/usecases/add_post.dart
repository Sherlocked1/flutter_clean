import 'package:dartz/dartz.dart';
import 'package:posts_clean/core/error/failures.dart';
import 'package:posts_clean/posts/domain/repositories/posts_repositories.dart';

import '../entities/post.dart';

class AddPost {
  final PostsRepository repository;

  AddPost(this.repository);

  Future<Either<Post, Failure>> call(Post post) async {
    return await repository.addPosat(post);
  }
}
