import 'package:equatable/equatable.dart';
import 'package:posts_clean/modules/posts/domain/entities/post.dart';

class PostDTO extends Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  const PostDTO({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  }) : super(id: id, title: title, body: body);

  factory PostDTO.fromJson(Map<String, dynamic> json) => PostDTO(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };

  @override
  List<Object?> get props => throw UnimplementedError();
}
