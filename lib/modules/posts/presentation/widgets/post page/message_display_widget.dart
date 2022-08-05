import 'package:flutter/material.dart';

class MessageDisplayWidget extends StatelessWidget {
  const MessageDisplayWidget({Key? key, required this.message})
      : super(key: key);

  final message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
