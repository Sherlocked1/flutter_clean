import 'package:flutter/material.dart';
import 'package:posts_clean/modules/posts/domain/entities/post.dart';
import 'package:posts_clean/modules/posts/presentation/pages/post_detail_page.dart';

class PostListWidget extends StatelessWidget {
  const PostListWidget({Key? key, required this.posts}) : super(key: key);

  final List<Post> posts;

  void goToPost(BuildContext context, Post post) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => PostDetailPage(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(posts[index].id.toString()),
            title: Text(posts[index].title),
            subtitle: Text(posts[index].body),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            onTap: () {
              goToPost(context, posts[index]);
            },
          );
        },
        separatorBuilder: (_, index) => Divider(
              height: 2,
            ),
        itemCount: posts.length);
  }
}
