import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/navigation.dart';
import 'package:cms/components/task-data.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom-drawer.dart';

class StudentProfile extends StatefulWidget {
  static String id = "student-profile";

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final _firestore = FirebaseFirestore.instance;
  double downloadProgress = 0.0;
  bool alreadyDisplayed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _globalKey,
      drawer: CustomDrawer(),
      body: ColorfulSafeArea(
        color: Color(0xFF13192F),
        child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('studentProfile').where('email', isEqualTo:Provider.of<TaskData>(context).userEmail).snapshots(),
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
                        !alreadyDisplayed) {
                      alreadyDisplayed = true;
                      final data = docs[i];
                      return Column(
                        children: [
                          CustomNavigation("Profile",(value) {
                            _globalKey.currentState?.openDrawer();
                          }),
                          Container(
                            child: Stack(
                              children: [
                                Container(
                                  height: 28.0,
                                  margin:
                                  EdgeInsets.only(right: 50.0, bottom: 1.0),
                                  color: Color(0xFF13192F),
                                ),
                                Container(
                                  height: 35.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0))),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(28.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    elevation: 3.0,
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xFF13192F),
                                      radius: 78.0,
                                      child: CircleAvatar(
                                        backgroundImage: Provider.of<TaskData>(
                                            context)
                                            .userPhoto ==
                                            ''
                                            ? NetworkImage(
                                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                                            : NetworkImage(Provider.of<
                                            TaskData>(context)
                                            .userPhoto),
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
                                "Batch ${data['batch']}",
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
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, bottom: 20.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width - 25.0,
                                      child: Text(
                                        data['bio'],
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFF13192F),
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                    padding: const EdgeInsets.only(
                                        left: 25.0, top: 20.0),
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
                                    padding: const EdgeInsets.only(
                                        left: 25.0, top: 20.0),
                                    child: Text(
                                      'Email: ' +
                                          Provider.of<TaskData>(context)
                                              .userEmail,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFF13192F),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }
            }),
      ),
    );
  }
}
