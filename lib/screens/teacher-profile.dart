import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/navigation.dart';
import 'package:cms/components/task-data.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom-drawer.dart';

class TeacherProfile extends StatefulWidget {
  static String id = "teacher-profile";

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        drawer: CustomDrawer(),
        body: ColorfulSafeArea(
          color: Color(0xFF13192F),
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('teacherProfile').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return LinearProgressIndicator();
                else {
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      if (docs[i].exists &&
                          docs[i]['email'] ==
                              Provider.of<TaskData>(context, listen: false)
                                  .userEmail) {
                        final data = docs[i];
                        return Column(
                          children: [
                            CustomNavigation((value){
                              _globalKey.currentState?.openDrawer();
                            }),
                            Container(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 30.0,
                                    margin: EdgeInsets.only(right: 50.0,bottom: 1.0),
                                    color: Color(0xFF13192F),
                                  ),
                                  Container(
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30.0))),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children:[
                                  Padding(
                                    padding: EdgeInsets.all(28.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(100.0),
                                      elevation: 3.0,
                                      child: CircleAvatar(
                                        backgroundColor: Color(0xFF13192F),
                                        radius: 78.0,
                                        child: CircleAvatar(
                                          backgroundImage:Provider.of<TaskData>(context).userPhoto =='' ? NetworkImage('https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-369-456321-512.png') : FileImage(File(Provider.of<TaskData>(context).userPhoto)) as ImageProvider,
                                          radius: 75.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  Provider.of<TaskData>(context).userName,
                                  style: TextStyle(
                                    fontSize: 27.0,
                                    color: Color(0xFF13192F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  data['position'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF13192F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Department of ' + data['dept'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Color(0xFF13192F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30.0,),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25.0, bottom: 20.0),
                                      child: Text(
                                        data['bio'],
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFF13192F),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                                      child: Text(
                                        'Phone: ' + data['mobile'],
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFF13192F),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25.0, top: 20.0),
                                      child: Text(
                                        'Email: ' + Provider.of<TaskData>(context).userEmail,
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFF13192F),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 40.0,),
                                    GestureDetector(
                                      onTap: downloadFile,
                                      child: Container(
                                        width: 300.0,
                                        margin: EdgeInsets.only(left: 25.0),
                                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xFF13192F), width: 2.0),
                                          color: Color(0xFF13192F),
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        child: Text(
                                          'Download Routine',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 16.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Container(
                          height: 0.0,
                        );
                      }
                    },
                  );
                }
              }),
        ),
    );
  }
  Future downloadFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/routine-pdf.pdf');
    String email = Provider.of<TaskData>(context, listen: false).userEmail;
    List<String> extension = ['pdf', 'png','jpg','jpeg'];
    extension.forEach((element) async {
      String fileToDownload = 'teacherRoutine/$email.$element';
      try {
        await FirebaseStorage.instance.ref(fileToDownload).writeToFile(downloadToFile);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Downloading Routine'),)
        );
        
      } on FirebaseException catch (e) {
        print('Amr Download error: $e');
      }

    });

  }
}
