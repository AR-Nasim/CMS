import 'dart:ui';

import 'package:cms/components/navigation2.dart';
import 'package:cms/components/task-data.dart';
import 'package:cms/screens/group-info.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

final messageTextController = TextEditingController();
final _firestore = FirebaseFirestore.instance;

late String messageText;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    String email = Provider.of<TaskData>(context, listen: false).userEmail;
    String name = Provider.of<TaskData>(context, listen: false).userName;
    String code = Provider.of<TaskData>(context, listen: false).courseCode;
    String batch = Provider.of<TaskData>(context, listen: false).courseBatch;
    String section = Provider.of<TaskData>(context, listen: false).courseSection;
    String classCode = Provider.of<TaskData>(context, listen: false).classCode;
    return Scaffold(
      body: ColorfulSafeArea(
        color: Color(0xFF13192F),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomNavigation2(batch, section, classCode, code,(){
              print('object');
              Navigator.pushNamed(context, GroupInfo.id);
            },),
            MessagesStream(),
            Container(
              padding: EdgeInsets.only(bottom: 7.0,left: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      cursorColor: Color(0xFF13192F),
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Type your message here..',
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF13192F), width: 1.5),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF13192F), width: 2.5),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    minWidth: 40.0,
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection('messages-$classCode').add({
                        'text': messageText,
                        'sender': email,
                        'name': name,
                        'messageSerial': DateFormat.Hms().format(DateTime.now()).toString(),
                        'messageTime': DateFormat.jm().format(DateTime.now()).toString(),
                      });
                    },
                    child: Icon(
                      Icons.send,
                      color: Color(0xFF13192F),
                      size: 38.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      child: Text(title),
      onTap: () {
        openDialog();
      },
    );
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Class Not Found'),
          content: Text('Sorry the given code is not valid!!'),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text('Ok'),
            )
          ],
        ),
      );
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String classCode = Provider.of<TaskData>(context, listen: false).classCode;
    return StreamBuilder<QuerySnapshot>(

      stream: _firestore
          .collection('messages-$classCode')
          .orderBy('messageSerial', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0xFF13192F),
            ),
          );
        }
        final messages = snapshot.data?.docs;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages!) {
          final messageText = message['text'];
          final messageSender = message['name'];
          final senderEmail = message['sender'];
          final messageTime = message['messageTime'];
          final currentUser = Provider.of<TaskData>(context, listen: false).userEmail;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            time: messageTime,
            isMe: currentUser == senderEmail,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {required this.sender,
      required this.text,
      required this.time,
      required this.isMe});

  final String sender;
  final String text;
  final String time;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Color(0xFF13192F) : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
