import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean/modules/posts/presentation/pages/post_form_page.dart';

import '../bloc/posts/posts_bloc.dart';
import '../widgets/post page/loading_widget.dart';
import '../widgets/post page/message_display_widget.dart';
import '../widgets/post page/posts_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: buildAddButton(context),
    );
  }

  FloatingActionButton buildAddButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const PostFormPage(isUpdatePost: false)));
      },
      child: Icon(Icons.add),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsInitial) {
          } else if (state is LoadingPostsState) {
            return LoadingWidget();
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh: () {
                BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
                return Future.value();
              },
              child: PostListWidget(
                posts: state.posts,
              ),
            );
          } else if (state is ErrorPostsState) {
            return MessageDisplayWidget(
              key: key,
              message: state.message,
            );
          }

          return LoadingWidget();
        },
      ),
    );
  }

  AppBar buildAppBar() => AppBar(title: Text("Posts"));
}
