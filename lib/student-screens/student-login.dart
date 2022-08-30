import 'package:cms/components/error-message.dart';
import 'package:cms/components/task-data.dart';
import 'package:cms/student-screens/student-login-verification.dart';
import 'package:cms/student-screens/student-register.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import '../components/input-field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../screens/forgot-password.dart';
import 'student-verification.dart';

class StudentLogin extends StatefulWidget {
  static String id = 'student-login';

  @override
  _StudentLoginState createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String errorMessage = '';
  late bool spinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: spinner
          ? const Center(
        child: SpinKitDoubleBounce(
          color: Color(0xFF13192F),
          size: 50.0,
        ),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Material(
                borderRadius: BorderRadius.circular(100),
                elevation: 5.0,
                child: CircleAvatar(
                  backgroundColor: Color(0xFF13192F),
                  radius: 73.0,
                  child: CircleAvatar(
                    radius: 70.0,
                    backgroundImage: AssetImage('images/CMS-Logo.png'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text("Login as Student",textAlign: TextAlign.center ,style: TextStyle(color: Color(0xFF13192F),fontSize: 20.0,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 30.0,
            ),
            InputField('Enter your email', false, (value) {
              email = value;
            }),
            const SizedBox(
              height: 10.0,
            ),
            InputField('Enter your password', true, (value) {
              password = value;
            }),
            const SizedBox(
              height: 10.0,
            ),
            ErrorMessage(errorMessage),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                color: Color(0xFF13192F),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        spinner = true;
                      });
                      await Firebase.initializeApp();
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Provider.of<TaskData>(context,listen:false).getUser();
                        Navigator.pushNamed(context, StudentLoginVerification.id);
                      }
                      setState(() {
                        spinner = false;
                      });
                    } catch (e) {
                      setState(() {
                        spinner = false;
                        errorMessage = e.toString();
                      });
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, ForgotPassword.id);
              },
              style: TextButton.styleFrom(
                primary: Color(0xFF13192F), // Text Color
              ),
              child: const Text(
                'Forgot password?',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('You don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, StudentRegister.id);
                  },
                  style: TextButton.styleFrom(
                    primary: Color(0xFF13192F), // Text Color
                  ),
                  child: const Text(
                    'Register Now',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
