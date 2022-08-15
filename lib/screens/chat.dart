import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/task-data.dart';
import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:provider/provider.dart';

import '../components/navigation.dart';
import 'add-group.dart';
import 'dart:math' as math;

class Chat extends StatefulWidget {
  static String id = 'chat';

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, AddGroup.id);
          },
          label: Text(
            "Add Groups",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xFF13192F),
        ),
        backgroundColor: Colors.white,
        body: ColorfulSafeArea(
            color: Color(0xFF13192F),
            child: Column(
              children: [
                Navigation(),
                Container(
                  child: Stack(
                    children: [
                      Container(
                        height: 30.0,
                        margin: EdgeInsets.only(right: 50.0),
                        color: Color(0xFF13192F),
                      ),
                      Container(
                        height: 30.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0))),
                      ),
                      Positioned(
                        child: GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Groups",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Text(
                                  "Resources",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('groups').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return LinearProgressIndicator();
                      else {
                        final docs = snapshot.data!.docs;
                        return Expanded(
                          child: SizedBox(
                            height: 500.0,
                            child: ListView.builder(
                              itemCount: docs.length,
                              itemBuilder: (context, i) {
                                if (docs[i].exists &&
                                    docs[i]['email'] ==
                                        Provider.of<TaskData>(context,
                                                listen: false)
                                            .userEmail) {
                                  final data = docs[i];
                                  String courseStr = "";
                                  String courseNo = "";
                                  String courseCode = data['groupName'];
                                  for (int j = 0; j < courseCode.length; j++) {
                                    if (courseCode[j]
                                        .contains(new RegExp(r'[0-9]'))) {
                                      courseNo += courseCode[j];
                                    } else if (courseCode[j]
                                        .contains(new RegExp(r'[A-z]'))) {
                                      courseStr += courseCode[j];
                                    }
                                  }
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 15.0),
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 5.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        courseStr,
                                                        style: TextStyle(
                                                            color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
                                                      ),
                                                      Text(
                                                        courseNo,
                                                        style: TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                    ]),
                                                radius: 35,
                                                backgroundColor: Color((math
                                                                    .Random()
                                                                .nextDouble() *
                                                            0xFFFFFF)
                                                        .toInt())
                                                    .withOpacity(0.6),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data['groupName'],
                                                      style: TextStyle(
                                                          fontSize: 21.0,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Batch '+data['groupBatch'],
                                                      style: TextStyle(
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ]),
                                            ]),
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom:
                                              BorderSide(color: Color(0xFF808080).withOpacity(0.4)),
                                        ),
                                      ),
                                    ),
                                  );
                                } else
                                  return Container();
                              }
                            ),
                          ),
                        );
                      }
                    }),
              ],
            )));
  }
}
