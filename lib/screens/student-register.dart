import 'package:cms/components/error-message.dart';
import 'package:cms/components/input-field.dart';
import 'package:cms/screens/login.dart';
import 'package:cms/screens/student-login.dart';
import 'package:cms/screens/varification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StudentRegister extends StatefulWidget {
  static String id = 'student-register';
  const StudentRegister({Key? key}) : super(key: key);

  @override
  _StudentRegisterState createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {
  final _auth = FirebaseAuth.instance;
  late String name;
  late String mobile;
  late String email;
  late String password;
  late String password2;
  late String errorMessage = '';
  late bool spinner = false;
  String setter() {
    return name;
  }

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
            Text("Create an account as Student",textAlign: TextAlign.center ,style: TextStyle(color: Color(0xFF13192F),fontSize: 20.0,fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 30.0,
            ),
            InputField('Enter your name', false, (value) {
              name = value;
            }),
            const SizedBox(
              height: 10.0,
            ),
            InputField('Enter mobile number', false, (value) {
              mobile = value;
            }),
            const SizedBox(
              height: 10.0,
            ),
            InputField('Enter your email', false, (value) {
              email = value;
            }),
            const SizedBox(
              height: 10.0,
            ),
            InputField('Enter a password', true, (value) {
              password = value;
            }),
            const SizedBox(
              height: 10.0,
            ),
            InputField('Confirm password', true, (value) {
              password2 = value;
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
                    if (password != password2) {
                      setState(() {
                        errorMessage = "Password didn't match";
                      });
                    } else {
                      setState(() {
                        spinner = true;
                      });
                      try {
                        await Firebase.initializeApp();
                        UserCredential? result;
                        if (email != null && password != null) {
                          result =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                        }
                        if (result != null) {
                          await _auth.currentUser
                              ?.updateDisplayName(name);
                          // Provider.of<TaskData>(context, listen: false)
                          //     .getUser();
                          Navigator.pushNamed(context, Varification.id);
                        }
                        setState(() {
                          spinner = false;
                        });
                      } catch (e) {
                        setState(() {
                          spinner = false;
                          errorMessage =
                              e.toString() + password + name + email;
                        });
                      }
                    }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('You don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, StudentLogin.id);
                  },
                  style: TextButton.styleFrom(
                    primary: Color(0xFF13192F), // Text Color
                  ),
                  child: const Text(
                    'Login',
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