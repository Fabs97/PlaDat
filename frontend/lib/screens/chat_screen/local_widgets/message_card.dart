import 'package:flutter/material.dart';
import 'package:frontend/models/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  const MessageCard({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Card(
      shadowColor: Colors.grey[800],
      child: Container(
        width: screenSize.width * .7,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(message.message),
        ),
      ),
    );
  }
}
