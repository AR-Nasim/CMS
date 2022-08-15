import 'package:cms/components/dropdown-field.dart';
import 'package:cms/components/input-field2.dart';
import 'package:cms/components/navigation.dart';
import 'package:cms/components/task-data.dart';
import 'package:cms/screens/chat.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../components/multi-dropdown-field.dart';
import '../components/navigation.dart';

class AddGroup extends StatefulWidget {
  static String id = 'add-group';

  @override
  _AddGroupState createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  final _firestore = FirebaseFirestore.instance;
  List<String> deptName = [
    'Select Department',
    'CSE',
    'EEE',
    'BBA',
    'LAW',
    'CE',
    'ENG'
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
        body: ColorfulSafeArea(
            color: Color(0xFF13192F),
            child: Column(
              children: [
                Navigation(),
                Container(
                  child: Stack(
                    children: [
                      Container(
                        height: 30.0,
                        margin: EdgeInsets.only(right: 50.0),
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
                      MultiDropdownField('Select Sections',_sectionValue, sectionName, (values) {
                        selectSectionList = values;
                        _sectionValue = '';
                        selectSectionList.forEach((element) {
                          setState(() {
                            _sectionValue = _sectionValue + ' ' + element.toString();
                          });
                        });
                        if(_sectionValue==''){
                          setState(() {
                            _sectionValue = 'Select Section';
                          });
                        }
                      },),
                      SizedBox(height: 15.0,),
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
                              if(element!='') {
                                _firestore.collection('subGroups').add({
                                  'groupName': courseCode.toUpperCase(),
                                  'groupBatch': batchNo,
                                  'groupSection': element,
                                  'email':
                                  Provider
                                      .of<TaskData>(context, listen: false)
                                      .userEmail
                                });
                              }
                            });
                            Navigator.pushNamed(context, Chat.id);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
