import 'dart:io';
import 'package:cms/screens/group-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cms/components/task-data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:image_picker/image_picker.dart';

import '../components/dropdown-field.dart';
import '../components/input-field2.dart';

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

  String _dropDownValue = 'CSE';
  List<String> items = ['CSE', 'EEE', 'BBA', 'LAW', 'CE'];
  late String bio;

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
                  // DecoratedBox(
                  //   decoration: BoxDecoration(
                  //     border:
                  //         Border.all(color: const Color(0xFF13192F), width: 2.0),
                  //     borderRadius: BorderRadius.circular(15.0),
                  //   ),
                  //   child: Padding(
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 20.0),
                  //     child: DropdownButton(
                  //       value: _dropDownValue,
                  //       items: items.map((String items) {
                  //         return DropdownMenuItem(
                  //           value: items,
                  //           child: Text(
                  //             items,
                  //             style: TextStyle(color: Colors.black),
                  //           ),
                  //         );
                  //       }).toList(),
                  //       onChanged: (String? newValue) {
                  //         setState(() {
                  //           _dropDownValue = newValue!;
                  //         });
                  //       },
                  //       underline: Container(),
                  //       isExpanded: true,
                  //     ),
                  //   ),
                  // ),
                  DropdownField(_dropDownValue, items, (value){
                    setState(() {
                      _dropDownValue = value;
                    });
                  }),
                  SizedBox(
                    height: 10.0,
                  ),
                  InputField2("Add Bio", false, (value){
                    bio = value;
                  }),
                  SizedBox(
                    height: 10.0,
                  ),
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
