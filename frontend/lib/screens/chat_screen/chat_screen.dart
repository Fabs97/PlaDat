import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/models/message.dart';
import 'package:frontend/screens/chat_screen/local_widgets/message_card.dart';
import 'package:frontend/services/api_service.dart';
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
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0.0);

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
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //TODO: change it with the student/company name
      appBar: CustomAppBar.createAppBar(context, "Student Name"),
      drawer: CustomDrawer.createDrawer(context),
      body: RefreshIndicator(
        onRefresh: () async => _requestMessages(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: widget._messages.isNotEmpty
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
                            return MessageCard(
                              message: message,
                              isByMe: message.sender == Sender.STUDENT,
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
                                        color: Colors.grey[600],
                                        onPressed:
                                            _createNewMessageButtonPressed,
                                        child: Text(
                                          'Create new message',
                                          style: TextStyle(color: Colors.white),
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
          // TODO: this has to be understood from the logged in user, PLAD-77 merging
          sender: Sender.STUDENT,
          sendDate: DateTime.now(),
        ),
      ).then((sentMessage) => setState(() {
            _sendingMessage = false;
            _creatingNewMessage = false;
            _newMessage = "";
            if (sentMessage != null) {
              Fluttertoast.showToast(msg: "Message sent!");
              widget._messages.insert(0, sentMessage);
            } else {
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
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    )),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                color: Colors.grey[600],
                onPressed: _sendMessageButtonPressed,
                child: Text(
                  'Send message',
                  style: TextStyle(color: Colors.white),
                ),
              ),
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
