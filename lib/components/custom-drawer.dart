import 'dart:io';

import 'package:cms/components/task-data.dart';
import 'package:cms/screens/login.dart';
import 'package:cms/screens/teacher-profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: const EdgeInsets.only(top: 0,bottom: 0,left: 15.0),
            decoration: const BoxDecoration(
                color: Color(0xFF13192F)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 42.0,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage:Provider.of<TaskData>(context).userPhoto =='' ? AssetImage('images/profile-img.png') : FileImage(File(Provider.of<TaskData>(context).userPhoto)) as ImageProvider,
                    radius: 40.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  Provider.of<TaskData>(context).userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    backgroundColor: Color(0xFF13192F),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Messages'),
                ),
                GestureDetector(
                  child: const ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profile'),
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, TeacherProfile.id);
                  },
                ),
                const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
                GestureDetector(
                    child: const ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                    ),
                    onTap: () {
                      Provider.of<TaskData>(context, listen: false).logOut();
                      Navigator.pushNamed(context, Login.id);
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
