import 'dart:ui';

import 'package:cms/components/navigation2.dart';
import 'package:cms/components/task-data.dart';
import 'package:cms/screens/group-info.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../student-screens/teacher-profile-2.dart';
import 'group-screen.dart';

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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(30.0)),
                color: Color(0xFF13192F),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 7.0),
                    child: CircleAvatar(
                      child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                              batch +'(' + section + ')',
                              style: TextStyle(
                                  color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500),
                            ),

                          ]),
                      radius: 24,
                      backgroundColor: Color((math.Random().nextDouble()*0xFFFF55).toInt()).withOpacity(0.6),
                    ),
                  ),

                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child:  Padding(
                        padding: EdgeInsets.all(7.0),
                        child: Text(code + '-' + batch + '(' + section + ')',
                          style: TextStyle(fontSize: 20.0,color: Colors.white, fontWeight: FontWeight.bold),),
                      )
                  ),
                  Expanded(
                    child: Row(
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        PopupMenuButton(
                          icon: Icon(Icons.more_vert_outlined,color: Colors.white,),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                child: TextButton(
                                   child: Text('Group Info',textAlign: TextAlign.left,style: TextStyle(color: Color(0xFF13192F),fontSize: 18.0,fontWeight: FontWeight.normal),),
                                  onPressed: ()=> Navigator.pushNamed(context, GroupInfo.id),
                                ),
                            ),
                            PopupMenuItem(
                              child: TextButton(
                                child: Text('Teacher Profile',textAlign: TextAlign.left,style: TextStyle(color: Color(0xFF13192F),fontSize: 18.0,fontWeight: FontWeight.normal),),
                                onPressed: ()=> Navigator.pushNamed(context, TeacherProfile2.id),
                              ),
                            ),
                            PopupMenuItem(
                              child: Padding(padding:EdgeInsets.only(left: 7.0),child: Text('Classroom Code')),
                              onTap: () {
                                Future.delayed(
                                    const Duration(seconds: 0),
                                        () => showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('This Classroom Code',textAlign: TextAlign.left,style: TextStyle(color: Color(0xFF13192F),fontSize: 18.0,fontWeight: FontWeight.normal)),
                                        content: Padding(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 0.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                classCode,
                                                style: TextStyle(
                                                    color: Color(0xFF13192F),
                                                    fontSize: 18.0),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.copy,
                                                  color: Color(0xFF13192F),
                                                  size: 18.0,
                                                ),
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(text: classCode));
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text('Ok',style: TextStyle(color: Color(0xFF13192F)),),
                                            onPressed: () => Navigator.pop(context),
                                          )
                                        ],
                                      ),
                                    ));
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            MessagesStream(),
            Container(
              padding: EdgeInsets.only(bottom: 7.0,left: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 18.0),
                      cursorColor: Color(0xFF13192F),
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Type your message here..',
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
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
                  Container(
                    padding: EdgeInsets.only(right: 7.0,bottom: 7.0),
                    child: IconButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestore.collection('messages-$classCode').add({
                          'text': messageText,
                          'sender': email,
                          'name': name,
                          'messageSerial': DateTime.now().toString(),
                          'messageTime': DateFormat.jm().format(DateTime.now()).toString(),
                        });
                      },
                      icon: Icon(
                        Icons.send,
                        color: Color(0xFF13192F),
                        size: 38.0,
                      ),
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
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                Text(
                  isMe ? '' : sender,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: isMe ? 0 : 14.0,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontSize: 18.0,
                  ),
                ),
                  Text(
                    time,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 11.0,
                      color:isMe ? Colors.white : Colors.black54,
                    ),
                  ),
    ]
              ),
            ),
          ),

        ],
      ),
    );
  }
}
