import 'package:flutter/material.dart';

class Varification extends StatefulWidget {
  static String id = 'verification';

  @override
  _VarificationState createState() => _VarificationState();
}

class _VarificationState extends State<Varification> {

  String sent = "A verification email has been sent to your email.";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Verification',
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(sent, style: TextStyle(fontSize: 20.0),textAlign: TextAlign.center,),
          const SizedBox(height: 10.0,),
          Padding(
            padding:const EdgeInsets.symmetric(horizontal: 100.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor:  Colors.lightBlueAccent,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.mail,size: 24.0,color: Colors.white,),
                  SizedBox(width: 10.0,),
                  Text('Resend',style: TextStyle(fontSize: 24.0,color: Colors.white),),
                ],

              ),
              onPressed: (){
                  setState(() {
                    sent = "A verification email has been resent to your email.";
                  });
              },
            ),
          )
        ],
      ),
    );
  }
}
