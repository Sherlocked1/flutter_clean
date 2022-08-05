import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean/core/app_theme.dart';
import 'package:posts_clean/modules/posts/presentation/bloc/crud/crud_bloc.dart';

import '../../../domain/entities/post.dart';

class FormWidget extends StatelessWidget {
  FormWidget({Key? key, required this.isUpdatePost, this.post})
      : super(key: key);

  final bool isUpdatePost;
  final Post? post;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: titleController..text = isUpdatePost ? post!.title : "",
          decoration: InputDecoration(hintText: "Title"),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: bodyController..text = isUpdatePost ? post!.body : "",
          decoration: InputDecoration(hintText: "Body"),
          minLines: 6,
          maxLines: 7,
        ),
        SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          icon: Icon(isUpdatePost ? Icons.edit : Icons.add),
          label: Text(
            isUpdatePost ? "Update" : "Add",
          ),
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
          ),
          onPressed: () {
            addOrUpdatePost(context);
          },
        )
      ],
    );
  }

  void addOrUpdatePost(BuildContext context) {
    final post = Post(
        id: isUpdatePost ? this.post!.id : 0,
        title: this.titleController.text,
        body: this.bodyController.text);

    if (isUpdatePost) {
      BlocProvider.of<CrudBloc>(context).add(UpdatePostEvent(post));
    } else {
      BlocProvider.of<CrudBloc>(context).add(AddPostEvent(post));
    }
  }
}
