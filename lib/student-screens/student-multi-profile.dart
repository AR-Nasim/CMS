import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/custom-drawer.dart';
import 'package:cms/components/task-data.dart';
import 'package:cms/screens/resource.dart';
import 'package:cms/student-screens/join-group.dart';
import 'package:cms/student-screens/student-group-screen.dart';
import 'package:cms/student-screens/student-profile.dart';
import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:provider/provider.dart';
import '../components/navigation.dart';
import 'dart:math' as math;

import '../screens/chat-screen.dart';

class StudentMultiProfile extends StatefulWidget {
  static String id = 'student-multi-profile';

  @override
  _StudentMultiProfileState createState() => _StudentMultiProfileState();
}

class _StudentMultiProfileState extends State<StudentMultiProfile> {
  final _firestore = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  bool alreadyDisplayed = false;

  @override
  Widget build(BuildContext context) {

    String email = Provider.of<TaskData>(context,listen: false).userEmail;
    return Scaffold(
        key: _globalKey,
        drawer: CustomDrawer(),
        backgroundColor: Colors.white,
        body: ColorfulSafeArea(
            color: Color(0xFF13192F),
            child: Column(
              children: [
                CustomNavigation("Profile",(value){
                  _globalKey.currentState?.openDrawer();
                }),
                Container(
                  child: Stack(
                    children: [
                      Container(
                        height: 28.0,
                        margin: EdgeInsets.only(right: 50.0),
                        color: Color(0xFF13192F),
                      ),
                      Container(
                        height: 35.0,
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
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, StudentGroupScreen.id);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 7.0),
                                    child: Text(
                                      "Groups",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 7.0),
                                  child: Text(
                                    "Profile",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:BorderSide(color: Colors.black,width: 3.0),
                                    ),
                                  ),
                                ),
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
              ],
            )));
  }
}
