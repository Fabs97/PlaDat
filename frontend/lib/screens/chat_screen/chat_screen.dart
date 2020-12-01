import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/message.dart';
import 'package:frontend/screens/chat_screen/local_widgets/message_card.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/widgets/drawer.dart';

class ChatScreenArguments {
  final int studentId;
  final int companyId;

  ChatScreenArguments(this.studentId, this.companyId);
}

class ChatScreen extends StatefulWidget {
  final ChatScreenArguments args;
  ChatScreen({Key key, @required this.args}) : super(key: key);
  List<Message> _messages = [];

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _creatingNewMessage = false;
  bool _sendingMessage = false;
  final _formKey = GlobalKey<FormState>();
  String _newMessage = "";

  @override
  void initState() {
    APIService.route(ENDPOINTS.Messages, "/messages").then((messagesList) {
      setState(() {
        widget._messages = messagesList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //TODO: change it with the student/company name
      appBar: CustomAppBar.createAppBar(context, "Student Name"),
      drawer: CustomDrawer.createDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget._messages.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.builder(
                    itemCount: widget._messages.length,
                    itemBuilder: (_, index) =>
                        MessageCard(message: widget._messages[index]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: _sendingMessage
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : !_creatingNewMessage && !_sendingMessage
                                ? TextButton(
                                    child: Text("Create new message"),
                                    onPressed: _createNewMessageButtonPressed,
                                  )
                                : _createMessageBoxAndButton(screenSize),
                      ),
                    ],
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  _createNewMessageButtonPressed() {
    setState(() {
      _creatingNewMessage = true;
    });
  }

  _sendMessageButtonPressed() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _sendingMessage = true;
      });
      //TODO correct route when backend is done
      APIService.route(ENDPOINTS.Messages, "/send-message")
          .then((messageSent) => setState(() {
                _sendingMessage = false;
                if (messageSent) {
                  Fluttertoast.showToast(msg: "Message sent!");
                } else {
                  Fluttertoast.showToast(
                      msg:
                          "Something went wrong while sending the message, please try again");
                }
              }));
    }
  }

  _createMessageBoxAndButton(Size screenSize) {
    return SizedBox(
      height: screenSize.height * .5,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextFormField(
              initialValue: _newMessage,
              onFieldSubmitted: _setMessage,
              onSaved: _setMessage,
              validator: (value) {
                if (value.isEmpty) return "Message can not be empty";
                return null;
              },
              maxLines: 5,
            ),
            TextButton(
              child: Text("Send message"),
              onPressed: _sendMessageButtonPressed,
            ),
          ],
        ),
      ),
    );
  }

  _setMessage(String message) {
    setState(() {
      _newMessage = message;
    });
  }
}
