import 'package:dartz/dartz.dart';
import 'package:posts_clean/core/error/failures.dart';
import '../repositories/posts_repositories.dart';

import '../entities/post.dart';

class GetAllPosts {
  final PostsRepository repository;

  GetAllPosts(this.repository);

  Future<Either<List<Post>, Failure>> call() async {
    return await repository.getAllPosts();
  }
}
