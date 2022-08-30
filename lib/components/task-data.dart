import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskData extends ChangeNotifier{
  final _auth = FirebaseAuth.instance;

  String userName = '';
  String userEmail = '';
  String userPhoto = '';
  String courseCode = '';
  String courseBatch = '';
  String courseSection = '';
  String classCode = '';
  String teacher = '';
  bool isStudent = false;

  void getUser() {
    userName = '';
    final user = _auth.currentUser;
    if(user!=null){
      List<String> splitted = user.displayName!.split(' ');
      if(splitted[splitted.length-1] != "student"){
        userName = user.displayName!;
      }
      else{
        isStudent = true;
        for(int i=0;i<splitted.length-1;i++){
          userName += splitted[i];
          if(i!=splitted.length-2)userName +=' ';
        }
      }
      userEmail = user.email!;
      if(user.photoURL != null) {
        userPhoto = user.photoURL!;
      }
    }
    notifyListeners();
  }

  void getGroup(String code, String batch){
    courseCode = code;
    courseBatch = batch;
    notifyListeners();
  }

  void getSubGroup(String section, String code,String newTeacher){
    courseSection = section;
    classCode = code;
    teacher = newTeacher;
    notifyListeners();
  }

  void updatePhoto(dynamic url)async{
    final user = _auth.currentUser;
    if(user!=null){
      await user.updatePhotoURL(url);
      getUser();
    }
    notifyListeners();
  }

  void logOut(){
    _auth.signOut();
    userName = '';
    userEmail = '';
    userPhoto = '';
    courseCode = '';
    courseBatch = '';
    courseSection = '';
    classCode = '';
    isStudent = false;
    notifyListeners();
  }
}