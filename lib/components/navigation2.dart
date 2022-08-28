import 'dart:ui';
import 'package:cms/screens/group-info.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

class CustomNavigation2 extends StatelessWidget {
  const CustomNavigation2(this.batch, this.section, this.code, this.name, this.onChangeCallback);
  final String batch;
  final String section;
  final String code;
  final String name;
  final Function onChangeCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.only(bottomRight: Radius.circular(30.0)),
        color: Color(0xFF13192F),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 7.0),
            child: CircleAvatar(
              child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Text(
                      batch +'(' + section + ')',
                      style: TextStyle(
                          color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500),
                    ),

                  ]),
              radius: 24,
              backgroundColor: Color((math.Random().nextDouble()*0xFFFF55).toInt()).withOpacity(0.6),
            ),
          ),

          Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child:  Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(name + '-' + batch + '(' + section + ')',
                  style: TextStyle(fontSize: 20.0,color: Colors.white, fontWeight: FontWeight.bold),),
              )
          ),
          Expanded(
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                PopupMenuButton(
                  icon: Icon(Icons.more_vert_outlined,color: Colors.white,),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Group Info'),
                      onTap:() => onChangeCallback
                    ),
                    PopupMenuItem(
                      child: Text('Classroom Code'),
                      onTap: () {
                        Future.delayed(
                            const Duration(seconds: 0),
                                () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('This Classroom Code'),
                                content: Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        code,
                                        style: TextStyle(
                                            color: Color(0xFF13192F),
                                            fontSize: 18.0),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.copy,
                                          color: Color(0xFF13192F),
                                          size: 18.0,
                                        ),
                                        onPressed: () {
                                          Clipboard.setData(ClipboardData(text: code));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('Ok',style: TextStyle(color: Color(0xFF13192F)),),
                                    onPressed: () => Navigator.pop(context),
                                  )
                                ],
                              ),
                            ));
                      },
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
