import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/input-field2.dart';
import 'package:cms/components/multi-dropdown-field.dart';
import 'package:cms/screens/group-screen.dart';
import 'package:cms/student-screens/student-group-screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cms/components/task-data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';

import '../components/dropdown-field.dart';

class StudentProfileUpdate extends StatefulWidget {
  static String id = 'student-profile-update';

  @override
  _StudentProfileUpdateState createState() => _StudentProfileUpdateState();
}

class _StudentProfileUpdateState extends State<StudentProfileUpdate> {
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  late bool isImage = false;
  final user =  FirebaseAuth.instance.currentUser;
  File? file = null;

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!;
    });
    File img = File(_imageFile.path);
    String newFileName = img.path.toString().split('/').last;
    final ref = FirebaseStorage.instance.ref().child('profileImages/${user?.email}/$newFileName');
    await ref.putFile(img).whenComplete(()async{
      await ref.getDownloadURL().then((value){
        user?.updatePhotoURL(value);
        Provider.of<TaskData>(context, listen: false).updatePhoto(value);
      }
      );
    });
  }

  final _firestore = FirebaseFirestore.instance;

  String _dropDownValue = 'Select Your Department';
  List<String> items = ['Select Your Department','CSE', 'EEE','Civil Engineering','Business Administration', 'LAW', 'English', 'Architecture', 'Islamic Study',
    'Public Health','Tourism and Hospitality Management','Bangla'];
  late String mobile = '';
  late String bio = '';
  late String batch = '';

  late CollectionReference routineRef;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Student Profile',
          ),
          backgroundColor: Color(0xFF13192F),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _firestore.collection('studentProfile').doc(Provider.of<TaskData>(context, listen: false).userEmail).set({
              'batch': batch,
              'dept': _dropDownValue,
              'bio': bio,
              'mobile': mobile,
              'email': Provider.of<TaskData>(context, listen: false).userEmail
            });
            Navigator.pushNamed(context, StudentGroupScreen.id);
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
                          ? NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                          : NetworkImage(Provider.of<TaskData>(context).userPhoto)
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
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DropdownField(_dropDownValue, items, (value) {
                      setState(() {
                        _dropDownValue = value;
                      });
                    }),
                    SizedBox(
                      height: 10.0,
                    ),
                    InputField2("Enter your batch", false, (value){

                    }),
                    SizedBox(
                      height: 10.0,
                    ),
                    InputField2("Add Bio", false, (value) {
                      setState(() {
                        bio = value;
                      });
                    }),
                    SizedBox(
                      height: 10.0,
                    ),
                    InputField2('Mobile Number', false, (value) {
                      setState(() {
                        mobile = value;
                      });
                    }),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
