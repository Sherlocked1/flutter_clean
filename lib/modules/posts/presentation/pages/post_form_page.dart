import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean/modules/posts/presentation/bloc/crud/crud_bloc.dart';

import '../../domain/entities/post.dart';
import '../widgets/form page/form_widget.dart';
import '../widgets/post page/loading_widget.dart';

class PostFormPage extends StatelessWidget {
  const PostFormPage({Key? key, required this.isUpdatePost, this.post})
      : super(key: key);

  final Post? post;
  final bool isUpdatePost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<CrudBloc, CrudState>(
          listener: (context, state) {
            if (state is CrudLoadedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
              Navigator.of(context).pop();
            } else if (state is CrudErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is CrudLoadingState) {
              return LoadingWidget();
            }
            return FormWidget(
              isUpdatePost: isUpdatePost,
              post: isUpdatePost ? post : null,
            );
          },
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(isUpdatePost ? 'Update' : 'Add'),
    );
  }
}
