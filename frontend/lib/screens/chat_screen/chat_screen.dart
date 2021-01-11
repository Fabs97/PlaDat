import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/message.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/screens/chat_screen/local_widgets/message_card.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/custom_theme.dart';
import 'package:frontend/widgets/appbar.dart';
import 'package:frontend/widgets/drawer.dart';

class ChatScreenArguments {
  final int studentId;
  final int employerId;

  ChatScreenArguments(this.studentId, this.employerId);
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
  final loggedUserIsEmployer =
      AuthService().loggedUser.type == AccountType.Employer;

  dynamic user;

  @override
  void initState() {
    _requestMessages();
    super.initState();
  }

  _requestMessages() {
    APIService.route(ENDPOINTS.Messages, "/message/:studentId/:employerId",
            urlArgs: widget.args)
        .then((messagesList) {
      setState(() {
        widget._messages = List.from((messagesList.cast<Message>()).reversed);
      });
    });
    if (loggedUserIsEmployer) {
      APIService.route(ENDPOINTS.Student, "/student/:id",
              urlArgs: widget.args.studentId)
          .then((value) => setState(() => user = value));
    } else {
      APIService.route(ENDPOINTS.Employers, "/employer/:id",
              urlArgs: widget.args.employerId)
          .then((value) => setState(() => user = value));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar.createAppBar(
          context,
          user == null
              ? (loggedUserIsEmployer ? "Student Name" : "Company Name")
              : (loggedUserIsEmployer
                  ? "${user.name} ${user.surname}"
                  : "${user.name}")),
      drawer: CustomDrawer.createDrawer(context),
      body: RefreshIndicator(
        onRefresh: () async => _requestMessages(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget._messages != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height:
                          screenSize.height * (_creatingNewMessage ? .3 : .8),
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: widget._messages.length,
                          reverse: true,
                          itemBuilder: (_, index) {
                            final message = widget._messages[index];
                            final messageSender = message.sender;
                            return MessageCard(
                              message: message,
                              isByMe: (messageSender == Sender.STUDENT &&
                                      !loggedUserIsEmployer) ||
                                  (messageSender == Sender.EMPLOYER &&
                                      loggedUserIsEmployer),
                            );
                          }),
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
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: RaisedButton(
                                        onPressed:
                                            _createNewMessageButtonPressed,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            'Create new message',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  : _createSendMessageButton(screenSize),
                        ),
                      ],
                    )
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
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
      APIService.route(
        ENDPOINTS.Messages,
        "/message",
        body: Message(
          studentId: widget.args.studentId,
          employerId: widget.args.employerId,
          message: _newMessage,
          sender: AuthService().loggedUser.type == AccountType.Student
              ? Sender.STUDENT
              : Sender.EMPLOYER,
          sendDate: DateTime.now(),
        ),
      ).then((response) => setState(() {
            _sendingMessage = false;
            _creatingNewMessage = false;
            _newMessage = "";
            if (response is Message) {
              Fluttertoast.showToast(msg: "Message sent!");
              widget._messages.insert(0, response);
            } else if (response is String) {
              Fluttertoast.showToast(
                  msg:
                      "Something went wrong while sending the message, please try again");
            }
          }));
    }
  }

  _createSendMessageButton(Size screenSize) {
    return SizedBox(
      height: screenSize.height * .5,
      width: screenSize.width * .855,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [CustomTheme().boxShadow],
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Colors.white54,
                  filled: true,
                  hintText: "Write your message here",
                ),
                initialValue: _newMessage,
                onFieldSubmitted: _setMessage,
                onSaved: _setMessage,
                onChanged: _setMessage,
                validator: (value) {
                  if (value.isEmpty) return "Message can not be empty";
                  return null;
                },
                maxLines: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: _sendMessageButtonPressed,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Send message',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
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
