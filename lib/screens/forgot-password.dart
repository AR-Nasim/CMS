import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  static String id = "forgot-password";

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF13192F),
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Receive an email to\nreset your password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: emailController,
                cursorColor: Color(0xFF13192F),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xFF13192F)),
                  hoverColor: Color(0xFF13192F),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF13192F)),
                    borderRadius: BorderRadius.circular(25.7),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      primary: Color(0xFF13192F)),
                  onPressed: resetPassword,
                  icon: Icon(Icons.email_outlined),
                  label: Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 24),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    try{
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Navigator.pop(context);
    }on Exception catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),));
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password resend email has been sent"),));
  }
}
