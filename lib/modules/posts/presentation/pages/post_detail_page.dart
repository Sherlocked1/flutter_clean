import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean/modules/posts/presentation/pages/post_form_page.dart';
import 'package:posts_clean/modules/posts/presentation/pages/posts_page.dart';
import 'package:posts_clean/modules/posts/presentation/widgets/post%20page/loading_widget.dart';

import '../../domain/entities/post.dart';
import '../bloc/crud/crud_bloc.dart';

class PostDetailPage extends StatelessWidget {
  PostDetailPage({Key? key, required this.post}) : super(key: key);

  Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }

  void routeToEdit(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PostFormPage(isUpdatePost: true, post: this.post)));
  }

  Widget buildBody(BuildContext context) => Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Text(
            post.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            post.body,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  onPressed: () {
                    routeToEdit(context);
                  },
                  icon: Icon(Icons.edit),
                  label: Text("Edit")),
              SizedBox(
                width: 10,
              ),
              ElevatedButton.icon(
                  onPressed: () => showDeleteDialog(context),
                  icon: Icon(Icons.delete),
                  label: Text("Delete")),
            ],
          )
        ]),
      );

  AppBar buildAppBar() {
    return AppBar(
      title: Text(post.id.toString()),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<CrudBloc, CrudState>(
            listener: (context, state) {
              if (state is CrudLoadedState) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => PostsPage()),
                    (route) => false);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is CrudErrorState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is CrudLoadingState) {
                return AlertDialog(
                  title: LoadingWidget(),
                );
              } else {
                return AlertDialog(
                  title: Text("Are you sure ?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          BlocProvider.of<CrudBloc>(context)
                              .add(DeletePostEvent(post.id));
                        },
                        child: Text("Yes")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No")),
                  ],
                );
              }
            },
          );
        });
  }
}
