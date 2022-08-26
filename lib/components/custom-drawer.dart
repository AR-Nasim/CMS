import 'package:cms/components/task-data.dart';
import 'package:cms/screens/group-screen.dart';
import 'package:cms/screens/subgroup-screen.dart';
import 'package:cms/screens/teacher-profile.dart';
import 'package:cms/screens/welcome-page.dart';
import 'package:cms/student-screens/student-group-screen.dart';
import 'package:cms/student-screens/student-profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/profile-settings.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool stud = Provider.of<TaskData>(context).isStudent;
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.only(top: 0,bottom: 0,left: 15.0),
            decoration: BoxDecoration(
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
                    backgroundImage: Provider.of<TaskData>(
                        context)
                        .userPhoto ==
                        ''
                        ? NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                        : NetworkImage(Provider.of<
                        TaskData>(context)
                        .userPhoto),
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
                GestureDetector(
                  child: const ListTile(
                    leading: Icon(Icons.group),
                    title: Text('Groups'),
                  ),
                  onTap: (){
                    String nextPage;
                    stud ? nextPage = StudentGroupScreen.id : nextPage = Groups.id;
                    Navigator.pushNamed(context,nextPage);
                  },
                ),
                GestureDetector(
                  child: const ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profile'),
                  ),
                  onTap: (){
                    String nextPage;
                    stud ? nextPage = StudentProfile.id : nextPage = TeacherProfile.id;
                    Navigator.pushNamed(context, nextPage);
                  },
                ),
                GestureDetector(
                  child: const ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, ProfileSettings.id);
                  },
                ),
                GestureDetector(
                    child: const ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                    ),
                    onTap: () {
                      Provider.of<TaskData>(context, listen: false).logOut();
                      Navigator.pushNamed(context, WelcomePage.id);
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
