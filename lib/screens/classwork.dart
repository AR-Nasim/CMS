import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/navigation.dart';
import 'package:cms/screens/add-class-work.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:math' as math;
import '../components/custom-drawer.dart';
import '../components/task-data.dart';

class Classwork extends StatefulWidget {
  static String id = 'class-work';
  const Classwork({Key? key}) : super(key: key);

  @override
  _ClassworkState createState() => _ClassworkState();
}

class _ClassworkState extends State<Classwork> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String code = Provider.of<TaskData>(context).classCode;
    return Scaffold(
      key: _globalKey,
      drawer: CustomDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF13192F),
        onPressed: () {
          showModalBottomSheet<void>(
              context: context, builder: (context) => AddClassWork());
        }, label:  Text('Add Classwork'),
      ),
      body: ColorfulSafeArea(
        color: Color(0xFF13192F),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNavigation("Classwork",(value) {
              _globalKey.currentState?.openDrawer();
            }),
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("classwork-$code").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return LinearProgressIndicator();
                  else {
                    final docs = snapshot.data!.docs;
                    return Expanded(
                        child: SizedBox(
                      height: 500.0,
                      child: ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, i) {
                            final data = docs[i];
                            return GestureDetector(
                              onLongPress: (){
                                Alert(
                                  context: context,
                                  type: AlertType.warning,
                                  title: "Confirm Delete",
                                  desc: "Are you sure you wanna delete this task?",
                                  buttons: [
                                    DialogButton(
                                      child:const Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () {
                                        _firestore.collection("classwork-$code").doc(data['classworkSerial']).delete();
                                        Navigator.pop(context);
                                      },
                                      color: Colors.red,
                                    ),
                                    DialogButton(
                                      child:const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                      color: Colors.green,
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ).show();

                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Container(
                                    margin: EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    color: Color((math.Random().nextDouble() *
                                                0xFFFFFF)
                                            .toInt())
                                        .withOpacity(0.6),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 20.0),
                                      color: Color(0xFF13192F),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Date: ${data['classworkTime']}",
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                            Text(
                                              data['classwork'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0),
                                            ),
                                          ]),
                                    )),
                              ),
                            );
                          }),
                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
