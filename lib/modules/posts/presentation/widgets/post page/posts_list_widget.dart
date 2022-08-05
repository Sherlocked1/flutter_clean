import 'package:flutter/material.dart';
import 'package:posts_clean/modules/posts/domain/entities/post.dart';

class PostListWidget extends StatelessWidget {
  const PostListWidget({Key? key, required this.posts}) : super(key: key);

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (_, index) {
          return ListTile(
            leading: Text(posts[index].id.toString()),
            title: Text(posts[index].title),
            subtitle: Text(posts[index].body),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            onTap: () {},
          );
        },
        separatorBuilder: (_, index) => Divider(
              height: 2,
            ),
        itemCount: posts.length);
  }
}
