import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/input-field2.dart';
import 'package:cms/components/multi-dropdown-field.dart';
import 'package:cms/screens/group-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cms/components/task-data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';

import '../components/dropdown-field.dart';

class TeacherProfileUpdate extends StatefulWidget {
  static String id = 'teacher-profile-update';

  @override
  _TeacherProfileUpdateState createState() => _TeacherProfileUpdateState();
}

class _TeacherProfileUpdateState extends State<TeacherProfileUpdate> {
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  late bool isImage = false;

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!;
    });
    Provider.of<TaskData>(context, listen: false).updatePhoto(_imageFile.path);
  }

  final _firestore = FirebaseFirestore.instance;

  String _position = ' Select Your Position';
  List<Object?> selectPositions = [];
  List<String> positions = ['Professor', 'Associate Professor', 'Assistance Professor', 'Head', 'Lecturer', 'Adjunct Faculty'];

  String _dropDownValue = 'CSE';
  List<String> items = ['CSE', 'EEE', 'BBA', 'LAW', 'CE'];
  late String mobile = '';
  late String bio = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Teacher Profile',
        ),
        backgroundColor: Color(0xFF13192F),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            _firestore.collection('teacherProfile').add({
              'position': _position,
              'dept': _dropDownValue,
              'bio': bio,
              'mobile': mobile,
              'email':
              Provider.of<TaskData>(context, listen: false)
                  .userEmail
            });
            Navigator.pushNamed(context, Groups.id);
        },
        backgroundColor: Color(0xFF13192F),
        child: Icon(Icons.arrow_forward_sharp),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40.0,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 100.0,
                  backgroundColor: Color(0xFF13192F),
                  child: CircleAvatar(
                    radius: 95.0,
                    backgroundImage: Provider.of<TaskData>(context).userPhoto ==
                            ''
                        ? AssetImage('images/profile-img.png')
                        : FileImage(
                                File(Provider.of<TaskData>(context).userPhoto))
                            as ImageProvider, // : FileImage() as ImageProvider,
                    backgroundColor: Colors.white,
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 150,
                  child: GestureDetector(
                    onTap: () {
                      Alert(
                        context: context,
                        content: Column(
                          children: [
                            Material(
                              elevation: 4,
                              child: DialogButton(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Icon(Icons.camera),
                                    Text(
                                      "Camera",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  takePhoto(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 4,
                              child: DialogButton(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(Icons.image),
                                      Text(
                                        "Gallery",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  color: Colors.white,
                                  onPressed: () {
                                    takePhoto(ImageSource.gallery);
                                    Navigator.pop(context);
                                  }),
                            ),
                          ],
                        ),
                        buttons: [],
                      ).show();
                    },
                    child: const CircleAvatar(
                      backgroundColor: Color(0xFF13192F),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              Provider.of<TaskData>(context).userName,
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MultiDropdownField('Select your position', _position, positions, (value){
                    setState(() {
                      selectPositions = value;
                      _position = '';
                      selectPositions.forEach((element) {
                        setState(() {
                          if(_position!='') {
                            _position = _position + ', ' + element.toString();
                          } else {
                            _position = element.toString();
                          }
                        });
                      });
                      if(_position==''){
                        setState(() {
                          _position = ' Select Your Position';
                        });
                      }
                    });
                  }),
                  SizedBox(
                    height: 10.0,
                  ),
                  DropdownField(_dropDownValue, items, (value){
                    setState(() {
                      _dropDownValue = value;
                    });
                  }),
                  SizedBox(
                    height: 10.0,
                  ),
                  InputField2("Add Bio", false, (value){
                    setState(() {
                      bio = value;
                    });
                  }),
                  SizedBox(
                    height: 10.0,
                  ),
                  InputField2('Mobile Number', false, (value){
                    setState(() {
                      mobile  =value;
                    });
                  }),
                  GestureDetector(
                    onTap: (){

                      Navigator.pushNamed(context, Groups.id);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF13192F),width: 2.0),
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 20.0),
                          child: Text(
                            "Add Routine",
                            style: TextStyle(color: Colors.black54,fontSize: 16.0),
                          ),
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
