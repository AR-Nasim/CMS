import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/input-field2.dart';
import 'package:cms/components/multi-dropdown-field.dart';
import 'package:cms/screens/group-screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cms/components/task-data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';

import '../components/dropdown-field.dart';

class TeacherEditProfile extends StatefulWidget {
  static String id = 'teacher-edit-profile';

  @override
  _TeacherEditProfileState createState() => _TeacherEditProfileState();
}

class _TeacherEditProfileState extends State<TeacherEditProfile> {
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  late bool isImage = false;
  final user = FirebaseAuth.instance.currentUser;

  File? file = null;

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!;
    });
    File img = File(_imageFile.path);
    String newFileName = img.path
        .toString()
        .split('/')
        .last;
    final ref = FirebaseStorage.instance.ref().child(
        'profileImages/${user?.email}/$newFileName');
    await ref.putFile(img).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        user?.updatePhotoURL(value);
        Provider.of<TaskData>(context, listen: false).updatePhoto(value);
      }
      );
    });
  }

  final _firestore = FirebaseFirestore.instance;

  String _position = ' Select Your Position';
  List<Object?> selectPositions = [];
  List<String> positions = [
    'Professor',
    'Associate Professor',
    'Assistance Professor',
    'Head',
    'Lecturer',
    'Adjunct Faculty'
  ];

  String _dropDownValue = 'Select Your Department';
  List<String> items = ['Select Your Department','CSE', 'EEE','Civil Engineering','Business Administration', 'LAW', 'English', 'Architecture', 'Islamic Study',
    'Public Health','Tourism and Hospitality Management','Bangla'];
  late String mobile = '';
  late String bio = '';

  late CollectionReference routineRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    await FirebaseFirestore.instance.collection('teacherProfile').where(
        'email', isEqualTo: user?.email).get().then((value) {
      final data = value.docs[0];
      setState(() {
        _dropDownValue = data['dept'];
        _position = data['position'];
        bio = data['bio'];
        mobile = data['mobile'];
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? file!
        .path
        .split('/')
        .last : "Add file";
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
        ),
        backgroundColor: Color(0xFF13192F),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _firestore.collection('teacherProfile').doc(Provider
              .of<TaskData>(context, listen: false)
              .userEmail).update({
            'name': user?.displayName,
            'photoURL': user?.photoURL,
            'position': _position,
            'dept': _dropDownValue,
            'bio': bio,
            'mobile': mobile,
            'email': Provider
                .of<TaskData>(context, listen: false)
                .userEmail
          });
          uploadFile();
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
                    backgroundImage: Provider
                        .of<TaskData>(context)
                        .userPhoto ==
                        ''
                        ? NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                        : NetworkImage(Provider
                        .of<TaskData>(context)
                        .userPhoto)
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
                                            color: Colors.black,
                                            fontSize: 20),
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
              Provider
                  .of<TaskData>(context)
                  .userName,
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
                  MultiDropdownField(
                      _position, _position, positions, (value) {
                    setState(() {
                      selectPositions = value;
                      _position = '';
                      selectPositions.forEach((element) {
                        setState(() {
                          if (_position != '') {
                            _position = _position + ', ' + element.toString();
                          } else {
                            _position = element.toString();
                          }
                        });
                      });
                      if (_position == '') {
                        setState(() {
                          _position = ' Select Your Position';
                        });
                      }
                    });
                  }),
                  SizedBox(
                    height: 10.0,
                  ),
                  DropdownField(_dropDownValue, items, (value) {
                    setState(() {
                      _dropDownValue = value;
                    });
                  }),
                  SizedBox(
                    height: 10.0,
                  ),
                  InputField2(bio, false, (value) {
                    setState(() {
                      bio = value;
                    });
                  }),
                  SizedBox(
                    height: 10.0,
                  ),
                  InputField2(mobile, false, (value) {
                    setState(() {
                      mobile = value;
                    });
                  }),
                  SizedBox(
                    height: 10.0,
                  ),
                  // GestureDetector(
                  //   onTap: selectFile,
                  //   child: Container(
                  //     width: screenWidth,
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: 12.0, horizontal: 20.0),
                  //     decoration: BoxDecoration(
                  //       border: Border.all(
                  //           color: Color(0xFF13192F), width: 2.0),
                  //       color: Color(0xFF13192F),
                  //       borderRadius: BorderRadius.circular(15.0),
                  //     ),
                  //     child: Text(
                  //       fileName,
                  //       style: TextStyle(
                  //           color: Colors.white, fontSize: 16.0),
                  //       overflow: TextOverflow.ellipsis,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  Future uploadFile() async {
    String email = Provider
        .of<TaskData>(context, listen: false)
        .userEmail;
    if (file == null) return;
    final fileName = file!
        .path
        .split('/')
        .last;
    final destination = 'teacherRoutine/$email/$fileName';
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      ref.putFile(file!).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          routineRef.add(
              {'url': fileName, 'email': email, 'fileName': fileName});
        }
        );
      });
    }
    catch (e) {
      return null;
    }
  }
}
