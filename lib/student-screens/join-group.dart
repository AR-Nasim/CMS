import 'package:cms/components/custom-drawer.dart';
import 'package:cms/components/dropdown-field.dart';
import 'package:cms/components/input-field2.dart';
import 'package:cms/components/navigation.dart';
import 'package:cms/components/task-data.dart';
import 'package:cms/screens/group-screen.dart';
import 'package:cms/student-screens/student-group-screen.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../components/multi-dropdown-field.dart';

class JoinGroup extends StatefulWidget {
  static String id = 'join-group';

  @override
  _JoinGroupState createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  final _firestore = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  late String classCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _globalKey,
        drawer: CustomDrawer(),
        body: ColorfulSafeArea(
            color: Color(0xFF13192F),
            child: Column(
              children: [
                CustomNavigation("Join Groups",(value){
                  _globalKey.currentState?.openDrawer();
                }),
                Container(
                  child: Stack(
                    children: [
                      Container(
                        height: 28.0,
                        margin: EdgeInsets.only(right: 50.0),
                        color: Color(0xFF13192F),
                      ),
                      Container(
                        height: 35.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputField2("Enter Class Code", false, (value) {
                        classCode = value;
                      }),
                      SizedBox(
                        height: 15.0,
                      ),
                      Material(
                        color: Color(0xFF13192F),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: MaterialButton(
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20.0),
                            child: Text(
                              "Join Group",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                          onPressed: () async {
                            _firestore.collection('subGroups').where('classCode', isEqualTo: classCode).get().then((value){
                                if(value.docs.length == 0){
                                  openDialog();
                                }
                                else{
                                    final data = value.docs[0];
                                    _firestore.collection('studentGroups').add({
                                      'groupName': data['groupName'],
                                      'groupBatch': data['groupBatch'],
                                      'groupSection': data['groupSection'],
                                      'classCode': data['classCode'],
                                      'teacher': data['email'],
                                      'email':
                                      Provider.of<TaskData>(context, listen: false)
                                          .userEmail
                                    });
                                    Navigator.pushNamed(context, StudentGroupScreen.id);
                                }
                            }).catchError((e){
                              print(e);
                            });

                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  Future openDialog() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Class Not Found'),
      content: Text('Sorry the given code is not valid!!'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Ok'),
        )
      ],

    ),
  );

}
