import 'package:flutter/material.dart';
import 'package:frontend/models/message.dart';
import 'package:frontend/services/auth_service.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  const MessageCard({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Row(
      //TODO: refactor this after PLAD-74 merge to dev
      mainAxisAlignment: message.sender == Sender.EMPLOYER ? MainAxisAlignment.start : MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          shadowColor: Colors.grey[800],
          color: message.sender == Sender.EMPLOYER ? Colors.grey[400] : Colors.white,
          child: Container(
            width: screenSize.width * .7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message.message),
            ),
          ),
        ),
      ],
    );
  }
}
