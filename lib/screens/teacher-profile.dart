
import 'dart:io';

import 'package:cms/components/navigation.dart';
import 'package:cms/components/task-data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom-drawer.dart';

class TeacherProfile extends StatelessWidget {
  static String id="teacher-profile";
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _globalKey,
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Column(
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
                    'Department of CSE',
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
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                        child: Text(
                          'Teachers Position',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xFF13192F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0, bottom: 20.0),
                        child: Text(
                          'Teachers Status(Advisor)',
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
                          'Phone: +880****',
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
          ),
        ),
      ),
    );
  }
}