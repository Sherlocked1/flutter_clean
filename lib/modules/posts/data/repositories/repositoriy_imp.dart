import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_clean/core/error/exception.dart';
import 'package:posts_clean/core/network/network_check.dart';
import 'package:posts_clean/modules/posts/data/datasources/local_data_source.dart';
import 'package:posts_clean/modules/posts/data/datasources/remote_data_source.dart';
import 'package:posts_clean/modules/posts/data/models/post_model.dart';
import 'package:posts_clean/modules/posts/domain/entities/post.dart';
import 'package:posts_clean/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_clean/modules/posts/domain/repositories/posts_repositories.dart';

class PostsRepositoryImp implements PostsRepository {
  final PostsRemoteDataSource remoteDataSource;
  final PostsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImp(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<List<Post>, Failure>> getAllPosts() async {
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final posts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(posts);

        return Left(posts);
      } else {
        return Left(await localDataSource.getPosts());
      }
    } on ServerException {
      return Right(
          ServerFailure(message: "Server failure please try again ..."));
    } on OfflineException {
      return Right(OfflineFailure(
          message: "Please check your internet connection and try again ..."));
    } on EmptyCacheException {
      return Right(EmptyCacheFailure(
          message: "Please check your internet connection and try again ..."));
    }
  }

  ///<comment>
  @override
  Future<Either<Post, Failure>> addPost(Post newPost) async {
    final post = PostDTO(
        userId: 1, id: newPost.id, title: newPost.title, body: newPost.body);
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final addedPost = await remoteDataSource.addPost(post);
        localDataSource.cachePosts([addedPost]);

        return Left(addedPost);
      } else {
        return Right(OfflineFailure(
            message:
                "Please check your internet connection and try again ..."));
      }
    } on ServerException {
      return Right(
          ServerFailure(message: "Server failure please try again ..."));
    } on OfflineException {
      return Right(OfflineFailure(
          message: "Please check your internet connection and try again ..."));
    } on EmptyCacheException {
      return Right(EmptyCacheFailure(
          message: "Please check your internet connection and try again ..."));
    }
  }

  @override
  Future<Either<bool, Failure>> deletePost(int id) async {
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final isDeleted = await remoteDataSource.deletePost(id);
        return Left(isDeleted);
      } else {
        return Right(OfflineFailure(
            message:
                "Please check your internet connection and try again ..."));
      }
    } on ServerException {
      return Right(
          ServerFailure(message: "Server failure please try again ..."));
    } on OfflineException {
      return Right(OfflineFailure(
          message: "Please check your internet connection and try again ..."));
    } on EmptyCacheException {
      return Right(EmptyCacheFailure(
          message: "Please check your internet connection and try again ..."));
    }
  }

  @override
  Future<Either<Post, Failure>> updatePost(Post newPost) async {
    final post = PostDTO(
        userId: 1, id: newPost.id, title: newPost.title, body: newPost.body);
    final isConnected = await networkInfo.isConnected;
    try {
      if (isConnected) {
        final addedPost = await remoteDataSource.updatePost(post);
        localDataSource.cachePosts([addedPost]);

        return Left(addedPost);
      } else {
        return Right(OfflineFailure(
            message:
                "Please check your internet connection and try again ..."));
      }
    } on ServerException {
      return Right(
          ServerFailure(message: "Server failure please try again ..."));
    } on OfflineException {
      return Right(OfflineFailure(
          message: "Please check your internet connection and try again ..."));
    } on EmptyCacheException {
      return Right(EmptyCacheFailure(
          message: "Please check your internet connection and try again ..."));
    }
  }
}
