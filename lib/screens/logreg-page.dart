import 'dart:ui';
import 'package:cms/screens/login.dart';
import 'package:cms/screens/register.dart';
import 'package:cms/student-screens/student-login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LogRegPage extends StatelessWidget {
  static String id="second-page";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF13192F),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: CircleAvatar(
                    radius: 85.0,
                    backgroundImage: AssetImage('images/CMS-Logo.png'),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, Login.id);
                  },
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Login as Teacher',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'or',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, StudentLogin.id);
                  },
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Login as Student',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}