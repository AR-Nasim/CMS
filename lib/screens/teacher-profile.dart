import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/navigation.dart';
import 'package:cms/components/task-data.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom-drawer.dart';

class TeacherProfile extends StatefulWidget {
  static String id = "teacher-profile";

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        drawer: CustomDrawer(),
        body: ColorfulSafeArea(
          color: Color(0xFF13192F),
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('teacherProfile').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return LinearProgressIndicator();
                else {
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      if (docs[i].exists &&
                          docs[i]['email'] ==
                              Provider.of<TaskData>(context, listen: false)
                                  .userEmail) {
                        final data = docs[i];
                        return Column(
                          children: [
                            CustomNavigation((value){
                              _globalKey.currentState?.openDrawer();
                            }),
                            Container(
                              child: Column(
                                children:[
                                  Padding(
                                    padding: EdgeInsets.all(28.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(100.0),
                                      elevation: 3.0,
                                      child: CircleAvatar(
                                        backgroundColor: Color(0xFF13192F),
                                        radius: 78.0,
                                        child: CircleAvatar(
                                          backgroundImage:Provider.of<TaskData>(context).userPhoto =='' ? NetworkImage('https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-369-456321-512.png') : FileImage(File(Provider.of<TaskData>(context).userPhoto)) as ImageProvider,
                                          radius: 75.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  Provider.of<TaskData>(context).userName,
                                  style: TextStyle(
                                    fontSize: 27.0,
                                    color: Color(0xFF13192F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  data['position'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF13192F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Department of ' + data['dept'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF13192F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30.0,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25.0, bottom: 20.0),
                                      child: Text(
                                        data['bio'],
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFF13192F),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                                      child: Text(
                                        'Phone: ' + data['mobile'],
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFF13192F),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                                      child: Text(
                                        'Email: ' + Provider.of<TaskData>(context).userEmail,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFF13192F),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Container(
                          height: 0.0,
                        );
                      }
                    },
                  );
                }
              }),
        ),
    );
  }
}
