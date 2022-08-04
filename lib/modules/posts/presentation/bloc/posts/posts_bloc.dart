import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean/modules/posts/domain/entities/post.dart';
import 'package:posts_clean/modules/posts/domain/usecases/get_all_posts.dart';

import '../../../../../core/error/failures.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPosts getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final posts = await getAllPosts();
        emit(getStateFor(posts));
      }
    });
  }

  PostsState getStateFor(Either<List<Post>, Failure> either) {
    return either.fold(
        (l) => LoadedPostsState(posts: l), (r) => ErrorPostsState(r.message));
  }
}
