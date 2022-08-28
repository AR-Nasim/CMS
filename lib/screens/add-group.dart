import 'dart:math';
import 'dart:ui';

import 'package:cms/components/custom-drawer.dart';
import 'package:cms/components/dropdown-field.dart';
import 'package:cms/components/input-field2.dart';
import 'package:cms/components/navigation.dart';
import 'package:cms/components/task-data.dart';
import 'package:cms/screens/group-screen.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../components/multi-dropdown-field.dart';

class AddGroup extends StatefulWidget {
  static String id = 'add-group';

  @override
  _AddGroupState createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  final _firestore = FirebaseFirestore.instance;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  List<String> deptName = [
    'Select Department',
    'CSE',
    'EEE',
    'Civil Engineering',
    'Business Administration',
    'LAW',
    'English',
    'Architecture',
    'Islamic Study',
    'Public Health',
    'Tourism and Hospitality Management',
    'Bangla'
  ];
  String _deptValue = 'Select Department';
  List<String> sectionName = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
  List<Object?> selectSectionList = [];
  String _sectionValue = 'Select Section';

  late String courseCode;
  late String batchNo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _globalKey,
        drawer: CustomDrawer(),
        body: ColorfulSafeArea(
            color: Color(0xFF13192F),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNavigation("Add Groups",(value) {
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
                  padding: EdgeInsets.only(left: 32.0,bottom: 10.0),
                    child: Text(
                  "Create Your Customize Groups",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF13192F)),
                  textAlign: TextAlign.left,
                )),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Column(
                    children: [
                      DropdownField(_deptValue, deptName, (value) {
                        setState(() {
                          _deptValue = value;
                        });
                      }),
                      SizedBox(
                        height: 15.0,
                      ),
                      InputField2("Enter Course Code", false, (value) {
                        courseCode = value;
                      }),
                      SizedBox(
                        height: 15.0,
                      ),
                      InputField2("Enter Batch", false, (value) {
                        batchNo = value;
                      }),
                      SizedBox(
                        height: 15.0,
                      ),
                      MultiDropdownField(
                        'Select Sections',
                        _sectionValue,
                        sectionName,
                        (values) {
                          selectSectionList = values;
                          _sectionValue = '';
                          selectSectionList.forEach((element) {
                            setState(() {
                              _sectionValue =
                                  _sectionValue + ' ' + element.toString();
                            });
                          });
                          if (_sectionValue == '') {
                            setState(() {
                              _sectionValue = 'Select Section';
                            });
                          }
                        },
                      ),
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
                              "Create Group",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                          onPressed: () {
                            _firestore.collection('groups').add({
                              'groupName': courseCode.toUpperCase(),
                              'groupBatch': batchNo,
                              'email':
                                  Provider.of<TaskData>(context, listen: false)
                                      .userEmail
                            });
                            final sections = _sectionValue.split(' ');
                            sections.forEach((element) {
                              if (element != '') {
                                String classCode = getClassCode();
                                _firestore.collection('subGroups').add({
                                  'groupName': courseCode.toUpperCase(),
                                  'groupBatch': batchNo,
                                  'groupSection': element,
                                  'email': Provider.of<TaskData>(context,
                                          listen: false)
                                      .userEmail,
                                  'classCode': classCode
                                });
                              }
                            });
                            Navigator.pushNamed(context, Groups.id);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  String getClassCode() {
    String uppercaseLetter = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String lowercaseLetter = "abcdefghijklmnopqrstuvwxyz";
    String digits = "0123456789";

    String char = '';
    String str = '';
    char += "$uppercaseLetter$lowercaseLetter$digits";
    str += List.generate(8, (index) {
      final indexRandom = Random().nextInt(char.length);
      return char[indexRandom];
    }).join('');
    return str;
  }
}
