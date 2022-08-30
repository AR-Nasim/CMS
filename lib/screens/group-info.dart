import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/navigation.dart';
import 'package:cms/components/task-data.dart';
import 'package:cms/screens/add-class-work.dart';
import 'package:cms/screens/classwork.dart';
import 'package:cms/screens/resource.dart';
import 'package:cms/student-screens/quiz.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../student-screens/student-resources.dart';

class GroupInfo extends StatefulWidget {
  static String id="group-info";

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  int participate = 0;

  getData()async{
    await FirebaseFirestore.instance.collection('studentGroups').where(
        'classCode', isEqualTo: Provider.of<TaskData>(context, listen: false).courseCode).get().then((value) {
      setState(() {
        participate = participate + 1;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    String email = Provider.of<TaskData>(context, listen: false).userEmail;
    String name = Provider.of<TaskData>(context, listen: false).userName;
    String code = Provider.of<TaskData>(context, listen: false).courseCode;
    String batch = Provider.of<TaskData>(context, listen: false).courseBatch;
    String section = Provider.of<TaskData>(context, listen: false).courseSection;

    return MaterialApp(
      home: Scaffold(
        body: ColorfulSafeArea(
          color: Color(0xFF13192F),
          child: Column(
            children: [
              CustomNavigation("Group Info",(value){

              }),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF13192F),
                        radius: 55.0,
                        child: CircleAvatar(
                          child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Text(
                                  batch +'(' + section + ')',
                                  style: TextStyle(
                                      color: Color(0xFF13192F),fontSize: 32,fontWeight: FontWeight.w500),
                                ),

                              ]),
                          backgroundColor: Colors.white,
                          radius: 50.0,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$code-$batch($section)",
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Color(0xFF13192F),
                          ),
                        ),
                        Text(
                          "$participate Participants",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xFF13192F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Text(
                          'Welcome to my Course',
                          style: TextStyle(
                            fontSize: 27.0,
                            color: Color(0xFF13192F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0, bottom: 20.0),
                        child: Text(
                          'Created by You, 8/16/2022',
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
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ReusableCard('Class Work',(value){
                          Navigator.pushNamed(context, Classwork.id);
                        }),
                      ),
                    ),
                    Expanded(child:
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: ReusableCard('Resources',(value){
                        Navigator.pushNamed(context, StudentResources.id);
                      }),
                    ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ReusableCard('Result',(){}),
                      ),
                    ),
                    Expanded(child:
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child:ReusableCard('Quiz',(value){
                        Navigator.pushNamed(context, Quiz.id);
                      }),
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  const ReusableCard(this.text,this.onChangeCallback);
  final String text;
  final Function onChangeCallback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onChangeCallback(true);
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ],
        ),
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Color(0xFF1D1E33),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}