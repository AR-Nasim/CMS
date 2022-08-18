import 'dart:async';

import 'package:cms/screens/teacher-profile-update.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Varification extends StatefulWidget {
  static String id = 'verification';

  @override
  _VarificationState createState() => _VarificationState();
}

class _VarificationState extends State<Varification> {
  bool isVarified = false;
  bool canResendEmail = true;
  Timer? timer;
  Color color = Color(0xFF808080);

  String sent = "A verification email has been sent to your email.";
  @override
  void initState(){
    super.initState();
    isVarified = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isVarified) {
      sendVarificationEmail();

      timer = Timer.periodic(Duration(seconds: 5), (_){
          checkEmailVarified();
      });
    }
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVarified()async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVarified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isVarified)timer?.cancel();
  }

  Future sendVarificationEmail() async{
    setState(() {
      color = Color(0xFF808080);
      canResendEmail = false;
    });
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      canResendEmail = true;
      color = Color(0xFF13192F);
    });
  }

  Widget build(BuildContext context) {
    if(isVarified) {
      return TeacherProfileUpdate();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'User Verification',
          ),
          backgroundColor: Color(0xFF13192F),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(sent, style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,),
            const SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: TextButton(

                style: TextButton.styleFrom(
                  backgroundColor: color,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.mail, size: 24.0, color: Colors.white,),
                    SizedBox(width: 10.0,),
                    Text('Resend',
                      style: TextStyle(fontSize: 24.0, color: Colors.white),),
                  ],

                ),
                onPressed: (){
                  canResendEmail?
                  setState(() {
                    sent = "A verification email has been resent to your email.";
                    sendVarificationEmail();
                  }):null;
                }
                ,
              ),
            )
          ],
        ),
      );
    }
  }
}
