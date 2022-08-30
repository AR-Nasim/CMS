import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/custom-drawer.dart';
import 'package:cms/components/task-data.dart';
import 'package:cms/screens/resource.dart';
import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:provider/provider.dart';
import '../components/navigation.dart';
import 'add-group.dart';
import 'dart:math' as math;

import 'chat-screen.dart';

class SubGroups extends StatefulWidget {
  static String id = 'sub-group';

  @override
  _SubGroupsState createState() => _SubGroupsState();
}

class _SubGroupsState extends State<SubGroups> {
  final _firestore = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String lastMessage = "Welcome to our group";

  @override
  Widget build(BuildContext context) {
    String email = Provider.of<TaskData>(context,listen: false).userEmail;
    String courseCode = Provider.of<TaskData>(context,
        listen: false)
        .courseCode;
    String courseBatch = Provider.of<TaskData>(context,
        listen: false)
        .courseBatch;
    return Scaffold(
        key: _globalKey,
        drawer: CustomDrawer(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, AddGroup.id);
          },
          label: Text(
            "Add Sub-Groups",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xFF13192F),
        ),
        backgroundColor: Colors.white,
        body: ColorfulSafeArea(
            color: Color(0xFF13192F),
            child: Column(
              children: [
                CustomNavigation("Groups",(value){
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
                                Container(
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
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:BorderSide(color: Colors.black,width: 3.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, Resources.id);
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 5.0),
                                      child: Text(
                                        "Resources",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
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
                    stream: _firestore.collection('subGroups').where('email', isEqualTo: email).where('groupName', isEqualTo: courseCode).where('groupBatch', isEqualTo: courseBatch).snapshots(),
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
                                    final data = docs[i];
                                    _firestore.collection("messages-${data['classCode']}").orderBy('messageTime', descending: true).get().then((value){
                                      lastMessage = "Welcome to our group";
                                          if(value.docs.length > 0) {
                                            lastMessage = value.docs[0]['text'];
                                          }
                                    });
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 15.0),
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
                                                        data['groupBatch'] +'(' + data['groupSection'] + ')',
                                                        style: TextStyle(
                                                            color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500),
                                                      ),

                                                    ]),
                                                radius: 28,
                                                backgroundColor: Color((math
                                                    .Random()
                                                    .nextDouble() *
                                                    0xFFFF55)
                                                    .toInt())
                                                    .withOpacity(0.6),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  Provider.of<TaskData>(context,listen:false).getSubGroup(data['groupSection'],data['classCode'],data['email']);
                                                  Navigator.pushNamed(context, ChatScreen.id);
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width - 100,
                                                  padding: EdgeInsets.only(bottom: 8.0),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom:
                                                      BorderSide(color: Color(0xFF808080).withOpacity(0.6)),
                                                    ),
                                                  ),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          data['groupName'] + '-' + data['groupBatch'] + '(' + data['groupSection'] + ')',
                                                          style: TextStyle(
                                                              fontSize: 19.0,
                                                              fontWeight:
                                                              FontWeight.w600),
                                                        ),
                                                        SizedBox(height: 2.0,),
                                                        Text(
                                                          lastMessage,
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.grey),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    );
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
