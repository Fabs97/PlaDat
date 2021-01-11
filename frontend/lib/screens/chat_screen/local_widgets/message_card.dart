import 'package:flutter/material.dart';
import 'package:frontend/models/message.dart';
import 'package:frontend/utils/custom_theme.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  final bool isByMe;
  const MessageCard({Key key, @required this.message, @required this.isByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment:
          isByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          shadowColor: Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(isByMe ? 0.0 : 15.0),
              bottomLeft: Radius.circular(isByMe ? 15.0 : 0.0),
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          color: isByMe ? Colors.white : CustomTheme().primaryColor,
          child: Container(
            width: screenSize.width * .7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message.message,
                style: TextStyle(
                  color: isByMe ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
