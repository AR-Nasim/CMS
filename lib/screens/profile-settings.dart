import 'dart:ui';

import 'package:cms/screens/teacher-profile-update.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/task-data.dart';
import '../student-screens/stundet-edit-profile.dart';
import 'teacher-edit-profile.dart';

class ProfileSettings extends StatefulWidget {
  static String id = "settings";

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    bool stud = Provider.of<TaskData>(context).isStudent;
    print(stud);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Color(0xFF13192F),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
            children: [
                GestureDetector(
                  onTap: (){
                    String nextPage;
                    stud ? nextPage = StudentEditProfile.id : nextPage = TeacherEditProfile.id;
                    Navigator.pushNamed(context, nextPage);
                  },
                  child: Container(
                    color: Color(0xFF13192F).withOpacity(.95),
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Edit Profile",style: TextStyle(fontSize: 18.0,color: Colors.white),),
                        Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,)
                      ],
                    ),
                  ),
                )
            ],
        ),
      ),
    );
  }
}
