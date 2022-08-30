import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/navigation.dart';
import 'package:cms/components/task-data.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom-drawer.dart';

class TeacherProfile2 extends StatefulWidget {
  static String id = "teacher-profile2";

  @override
  State<TeacherProfile2> createState() => _TeacherProfile2State();
}

class _TeacherProfile2State extends State<TeacherProfile2> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final _firestore = FirebaseFirestore.instance;
  double downloadProgress = 0.0;
  bool alreadyDisplayed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _globalKey,
      drawer: CustomDrawer(),
      body: ColorfulSafeArea(
        color: Color(0xFF13192F),
        child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('teacherProfile').where('email', isEqualTo:Provider.of<TaskData>(context).teacher).snapshots(),
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
                        !alreadyDisplayed) {
                      alreadyDisplayed = true;
                      final data = docs[i];
                      return Column(
                        children: [
                          CustomNavigation("Teacher Profile",(value) {
                            _globalKey.currentState?.openDrawer();
                          }),
                          Container(
                            child: Stack(
                              children: [
                                Container(
                                  height: 28.0,
                                  margin:
                                  EdgeInsets.only(right: 50.0, bottom: 1.0),
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
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(28.0),
                                  child: Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    elevation: 3.0,
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xFF13192F),
                                      radius: 78.0,
                                      child: CircleAvatar(
                                        backgroundImage: data['photoURL'] ==
                                            ''
                                            ? NetworkImage(
                                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                                            : NetworkImage(data['photoURL']),
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
                                data['name'],
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
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, bottom: 20.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width - 25.0,
                                      child: Text(
                                        data['bio'],
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Color(0xFF13192F),
                                          fontWeight: FontWeight.bold,
                                        ),
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
                                    padding: const EdgeInsets.only(
                                        left: 25.0, top: 20.0),
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
                                    padding: const EdgeInsets.only(
                                        left: 25.0, top: 20.0),
                                    child: Text(
                                      'Email: ' +
                                          Provider.of<TaskData>(context)
                                              .teacher,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Color(0xFF13192F),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('routineURLs')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                return !snapshot.hasData
                                    ? Center(
                                  child:
                                  CircularProgressIndicator(
                                    backgroundColor: Colors.black,
                                  ),
                                )
                                    : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, index) {
                                      final data = snapshot.data!.docs[index];
                                      final url = data['url'];
                                      String email = Provider.of<TaskData>(
                                          context,listen: false).teacher;
                                      if (data['email'] == email) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                                          child: GestureDetector(
                                            onTap: (){
                                              downloadFile(url, data['fileName']);
                                            },
                                            child: ListTile(
                                              title: Text('Download Routine',style: TextStyle(fontSize: 18.0,color: Color(0xFF13192F)),),

                                              trailing: IconButton(
                                                onPressed: (){
                                                  downloadFile(url, data['fileName']);
                                                },
                                                icon: Icon(Icons.download_sharp),
                                              ),

                                            ),
                                          ),
                                        );
                                      }
                                      else return Container();
                                    });
                              })
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }
            }),
      ),
    );
  }

  Future downloadFile(final url, String fileName) async {
    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/$fileName';
    await Dio().download(url, path);
    if(url.contains('.jpg') || url.contains('.png') || url.contains('.jpeg')){
      await GallerySaver.saveImage(path,toDcim: true);
    }
    if(url.contains('.mp4')){
      await GallerySaver.saveVideo(path,toDcim: true);
    }
    print('object');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Download Completed"),));
  }

}
