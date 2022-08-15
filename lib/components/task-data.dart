import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskData extends ChangeNotifier{
  final _auth = FirebaseAuth.instance;

  String userName = '';
  String userEmail = '';
  String userPhoto = '';

  void getUser() {
    final user = _auth.currentUser;
    if(user!=null){
      userName = user.displayName!;
      userEmail = user.email!;
      if(user.photoURL != null) {
        userPhoto = user.photoURL!;
      }
    }
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
    notifyListeners();
  }
}