import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/custom-drawer.dart';
import 'package:cms/components/task-data.dart';
import 'package:cms/screens/subgroup-screen.dart';
import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../components/navigation.dart';
import 'add-group.dart';
import 'dart:math' as math;


class Groups extends StatefulWidget {
  static String id = 'group';

  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final _firestore = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String email = Provider.of<TaskData>(context, listen: false).userEmail;
    String code = Provider.of<TaskData>(context, listen: false).courseCode;
    String batch = Provider.of<TaskData>(context, listen: false).courseBatch;
    return Scaffold(
        key: _globalKey,
        drawer: CustomDrawer(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, AddGroup.id);
          },
          label: Text(
            "Add Groups",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xFF13192F),
        ),
        backgroundColor: Colors.white,
        body: ColorfulSafeArea(
            color: Color(0xFF13192F),
            child: Column(
              children: [
                CustomNavigation("CMS",(value){
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
                      Positioned(
                        child: GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 7.0),
                                    child: Text(
                                      "Groups",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:BorderSide(color: Colors.black,width: 3.0),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Container(
                                  child: GestureDetector(
                                    onTap: (){
                                      //Navigator.pushNamed(context, Resources.id);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 5.0),
                                      child: Text(
                                        "Notifications",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('groups').where('email', isEqualTo: Provider.of<TaskData>(context,listen: false).userEmail).snapshots(),
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
                                  String courseStr = "";
                                  String courseNo = "";
                                  String courseCode = data['groupName'];
                                  for (int j = 0; j < courseCode.length; j++) {
                                    if (courseCode[j]
                                        .contains(new RegExp(r'[0-9]'))) {
                                      courseNo += courseCode[j];
                                    } else if (courseCode[j]
                                        .contains(new RegExp(r'[A-z]'))) {
                                      courseStr += courseCode[j];
                                    }
                                  }
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 15.0),
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      courseStr,
                                                      style: TextStyle(
                                                          color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500),
                                                    ),
                                                    Text(
                                                      courseNo,
                                                      style: TextStyle(
                                                          color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),
                                                    ),
                                                  ]),
                                              radius: 28,
                                              backgroundColor: Color((math
                                                                  .Random()
                                                              .nextDouble() *
                                                          0xFFFFFF)
                                                      .toInt())
                                                  .withOpacity(0.6),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            GestureDetector(
                                              onTap: (){
                                                Provider.of<TaskData>(context,listen:false).getGroup(data['groupName'], data['groupBatch']);
                                                Navigator.pushNamed(context, SubGroups.id);
                                              },
                                                onLongPress: ()async{
                                                  Alert(
                                                    context: context,
                                                    type: AlertType.warning,
                                                    title: "Confirm Delete",
                                                    desc: "Are you sure you wanna delete this Group?",
                                                    buttons: [
                                                      DialogButton(
                                                        child:const Text(
                                                          "Delete",
                                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                                        ),
                                                        onPressed: () async{
                                                          await FirebaseFirestore.instance.collection('subGroups').where('email', isEqualTo: email).where('groupName', isEqualTo: data['groupName']).where('groupBatch', isEqualTo: data['groupBatch']).get().then((value)async {
                                                            await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                                              for(i=0;i<value.docs.length;i++){
                                                                await myTransaction.delete(value.docs[i].reference);
                                                              }
                                                            });
                                                          });
                                                          await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                                            await myTransaction.delete(snapshot.data!.docs[i].reference);
                                                          });
                                                          Navigator.pop(context);
                                                        },
                                                        color: Color(0xFFE94560),
                                                      ),
                                                      DialogButton(
                                                        child:const Text(
                                                          "Cancel",
                                                          style: TextStyle(color: Colors.white, fontSize: 20),
                                                        ),
                                                        color: Color(0xFF53BF9D),
                                                        onPressed: () => Navigator.pop(context),
                                                      ),
                                                    ],
                                                  ).show();

                                                },
                                              child: Container(
                                                width: MediaQuery.of(context).size.width - 100,
                                                padding: EdgeInsets.only(bottom: 8.0),
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom:
                                                    BorderSide(color: Color(0xFF808080).withOpacity(0.6)),
                                                  ),
                                                ),
                                                child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        data['groupName'],
                                                        style: TextStyle(
                                                            fontSize: 19.0,
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      ),
                                                      Text(
                                                        'Batch '+data['groupBatch'],
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                            FontWeight.w400),
                                                      ),
                                                    ]),
                                              )
                                            ),
                                          ]),
                                    ),
                                  );
                              }
                            ),
                          ),
                        );
                      }
                    }),
              ],
            )));
  }
}
