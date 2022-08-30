
import 'package:flutter/material.dart';

import 'logreg-page.dart';

class WelcomePage extends StatelessWidget {
  static String id="welcome-page";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF13192F),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
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
                    radius: 90.0,
                    backgroundImage: AssetImage('images/CMS-Logo.png'),
                  ),
                ),
                Container(
                  height: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 100.0,bottom: 50.0),
                        child: Material(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40.0),
                          ),
                          color: Colors.white,
                          elevation: 10.0,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LogRegPage.id);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'Get Started',
                                style: TextStyle(color: Color(0xFF13192F),fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}