import 'package:cms/screens/add-class-work.dart';
import 'package:cms/screens/classwork.dart';
import 'package:cms/screens/forgot-password.dart';
import 'package:cms/screens/group-info.dart';
import 'package:cms/screens/onboarding-screen.dart';
import 'package:cms/screens/profile-settings.dart';
import 'package:cms/screens/add-group.dart';
import 'package:cms/screens/add-image.dart';
import 'package:cms/screens/group-screen.dart';
import 'package:cms/screens/image-resource.dart';
import 'package:cms/screens/login.dart';
import 'package:cms/screens/register.dart';
import 'package:cms/screens/teacher-profile-update.dart';
import 'package:cms/screens/teacher-profile.dart';
import 'package:cms/screens/video.resource.dart';
import 'package:cms/screens/welcome-page.dart';
import 'package:cms/student-screens/quiz.dart';
import 'package:cms/student-screens/student-group-screen.dart';
import 'package:cms/student-screens/student-image-resources.dart';
import 'package:cms/student-screens/student-multi-profile.dart';
import 'package:cms/student-screens/student-resources.dart';
import 'package:cms/student-screens/student-video-resources.dart';
import 'package:cms/student-screens/teacher-profile-2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cms/components/task-data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/add-video.dart';
import 'screens/chat-screen.dart';
import 'screens/login-varification.dart';
import 'screens/logreg-page.dart';
import 'screens/resource.dart';
import 'screens/teacher-edit-profile.dart';
import 'student-screens/join-group.dart';
import 'student-screens/student-login-verification.dart';
import 'student-screens/student-login.dart';
import 'student-screens/student-profile-update.dart';
import 'student-screens/student-profile.dart';
import 'student-screens/student-register.dart';
import 'student-screens/student-verification.dart';
import 'screens/subgroup-screen.dart';
import 'screens/varification.dart';
import 'student-screens/stundet-edit-profile.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  String currentPage = OnBoardingScreen.id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStart();
  }
  void getStart()async{

    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if(user!=null){
      List<String> splitted = user.displayName!.split(' ');
      if(splitted[splitted.length-1] != "student"){
        currentPage = Groups.id;
      }
      else{
        currentPage = StudentGroupScreen.id;
      }
      await Future.delayed(Duration(milliseconds: 1000),(){
        Provider.of<TaskData>(context,listen: false).getUser();
      });
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen == false){
      await prefs.setBool('seen', true);
      currentPage = OnBoardingScreen.id;
    }

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: currentPage,
      routes: {
        WelcomePage.id: (context) => WelcomePage(),
        OnBoardingScreen.id: (context) => OnBoardingScreen(),
        LogRegPage.id: (context) => LogRegPage(),
        Login.id: (context) => Login(),
        ForgotPassword.id: (context) => ForgotPassword(),
        Register.id: (context) => const Register(),
        Varification.id: (context) => Varification(),
        LoginVarification.id: (context) => LoginVarification(),
        TeacherProfileUpdate.id: (context) => TeacherProfileUpdate(),
        TeacherProfile.id: (context) => TeacherProfile(),
        TeacherEditProfile.id:(context) => TeacherEditProfile(),
        AddGroup.id: (context) => AddGroup(),
        SubGroups.id: (context) => SubGroups(),
        ChatScreen.id: (context) => ChatScreen(),
        Groups.id: (context) => Groups(),
        GroupInfo.id:(context) => GroupInfo(),
        Resources.id: (context) => Resources(),
        ImageResources.id: (context) => ImageResources(),
        AddImage.id:(context) => AddImage(),
        VideoResources.id: (context) => VideoResources(),
        AddVideo.id: (context) => AddVideo(),
        Classwork.id: (context) => Classwork(),
        AddClassWork.id: (context) => AddClassWork(),

        ProfileSettings.id: (context) => ProfileSettings(),

        StudentLogin.id: (context) => StudentLogin(),
        StudentRegister.id: (context) => StudentRegister(),
        StudentGroupScreen.id: (context) => StudentGroupScreen(),
        StudentVerification.id: (context) => StudentVerification(),
        StudentLoginVerification.id: (context) => StudentLoginVerification(),
        StudentProfileUpdate.id: (context) => StudentProfileUpdate(),
        StudentProfile.id: (context) => StudentProfile(),
        StudentMultiProfile.id: (context) => StudentMultiProfile(),
        StudentEditProfile.id: (context) => StudentEditProfile(),
        StudentResources.id:(context) => StudentResources(),
        StudentImageResources.id: (context) => StudentImageResources(),
        StudentVideoResources.id: (context) => StudentVideoResources(),
        TeacherProfile2.id:(context) => TeacherProfile2(),
        JoinGroup.id: (context) => JoinGroup(),
        Quiz.id:(context) => Quiz(),

      },
    );

  }
}
