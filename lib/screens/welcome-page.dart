
import 'package:flutter/material.dart';

import 'logreg-page.dart';

class WelcomePage extends StatelessWidget {
  static String id="welcome-page";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF13192F),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:   [
                Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: Text(
                    'WELCOME TO',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, LogRegPage.id);
                  },
                  child: CircleAvatar(
                    radius: 85.0,
                    backgroundImage: AssetImage('images/CMS-Logo.png'),
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