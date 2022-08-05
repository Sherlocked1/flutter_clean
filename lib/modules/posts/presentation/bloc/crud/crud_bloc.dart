import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean/modules/posts/domain/usecases/add_post.dart';
import 'package:posts_clean/modules/posts/domain/usecases/delete_post.dart';
import 'package:posts_clean/modules/posts/domain/usecases/update_post.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/post.dart';

part 'crud_event.dart';
part 'crud_state.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  AddPost addPost;
  UpdatePost updatePost;
  DeletePost deletePost;

  CrudBloc(
      {required this.addPost,
      required this.deletePost,
      required this.updatePost})
      : super(CrudInitial()) {
    on<CrudEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(CrudLoadingState());
        final result = await addPost(event.post);
        emit(getState(result, isUpdate: false));
      } else if (event is DeletePostEvent) {
        emit(CrudLoadingState());
        final result = await deletePost(event.id);
        emit(getStateForDelete(result));
      } else if (event is UpdatePostEvent) {
        emit(CrudLoadingState());
        final result = await updatePost(event.post);
        emit(getState(result, isUpdate: true));
      }
    });
  }

  CrudState getStateForDelete(Either<bool, Failure> either) {
    return either.fold((_) => const CrudLoadedState(message: "Success"),
        (r) => CrudErrorState(message: r.message));
  }

  CrudState getState(Either<Post, Failure> either, {required bool isUpdate}) {
    return either.fold((_) {
      if (isUpdate) {
        return const CrudLoadedState(message: "Successfully updated the post");
      } else {
        return const CrudLoadedState(message: "Successfully added the post");
      }
    }, (r) => CrudErrorState(message: r.message));
  }
}
