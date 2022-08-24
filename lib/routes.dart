import 'package:cms/screens/add-group.dart';
import 'package:cms/screens/add-image.dart';
import 'package:cms/screens/group-screen.dart';
import 'package:cms/screens/image-resource.dart';
import 'package:cms/screens/login.dart';
import 'package:cms/screens/register.dart';
import 'package:cms/screens/teacher-profile-update.dart';
import 'package:cms/screens/teacher-profile.dart';
import 'package:cms/screens/video.resource.dart';
import 'package:cms/screens/welcome-page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cms/components/task-data.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/add-video.dart';
import 'screens/chat-screen.dart';
import 'screens/login-varification.dart';
import 'screens/logreg-page.dart';
import 'screens/resource.dart';
import 'screens/student-login.dart';
import 'screens/student-register.dart';
import 'screens/subgroup-screen.dart';
import 'screens/varification.dart';


class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  String currentPage = WelcomePage.id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStart();
  }
  void getStart()async{
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if(user!=null) {
      currentPage = Groups.id;
      await Future.delayed(Duration(milliseconds: 500),(){
        Provider.of<TaskData>(context,listen: false).getUser();
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: currentPage,
      routes: {
        WelcomePage.id: (context) => WelcomePage(),
        LogRegPage.id: (context) => LogRegPage(),
        Login.id: (context) => Login(),
        Register.id: (context) => const Register(),
        Varification.id: (context) => Varification(),
        LoginVarification.id: (context) => LoginVarification(),
        TeacherProfileUpdate.id: (context) => TeacherProfileUpdate(),
        TeacherProfile.id: (context) => TeacherProfile(),
        AddGroup.id: (context) => AddGroup(),
        SubGroups.id: (context) => SubGroups(),
        ChatScreen.id: (context) => ChatScreen(),
        Groups.id: (context) => Groups(),
        Resources.id: (context) => Resources(),
        ImageResources.id: (context) => ImageResources(),
        AddImage.id:(context) => AddImage(),
        VideoResources.id: (context) => VideoResources(),
        AddVideo.id: (context) => AddVideo(),
        StudentLogin.id: (context) => StudentLogin(),
        StudentRegister.id: (context) => StudentRegister(),

      },
    );
  }
}
