import 'package:cms/screens/add-group.dart';
import 'package:cms/screens/chat.dart';
import 'package:cms/screens/login.dart';
import 'package:cms/screens/register.dart';
import 'package:cms/screens/teacher-profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cms/components/task-data.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/varification.dart';


class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  String currentPage = Login.id;
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
      currentPage = Chat.id;
      await Future.delayed(Duration(milliseconds: 500),(){
        Provider.of<TaskData>(context,listen: false).getUser();
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: TextTheme(
            headline6: TextStyle(fontSize: 16 , color: Color(0xFF13192F)),
            bodyText1: TextStyle(backgroundColor: Colors.white , color: Color(0xFF13192F)) ,
          )
      ),
      initialRoute: currentPage,
      routes: {
        Login.id: (context) => Login(),
        Register.id: (context) => const Register(),
        Varification.id: (context) => Varification(),
        Chat.id: (context) => Chat(),
        TeacherProfile.id: (context) => TeacherProfile(),
        AddGroup.id: (context) => AddGroup(),
      },
    );
  }
}
