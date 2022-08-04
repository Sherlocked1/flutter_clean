import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../repositories/posts_repositories.dart';

class DeletePost {
  final PostsRepository repository;

  DeletePost(this.repository);

  Future<Either<bool, Failure>> call(int id) async {
    return await repository.deletePost(id);
  }
}
