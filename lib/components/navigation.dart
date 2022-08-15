import 'dart:io';
import 'package:cms/components/custom-drawer.dart';
import 'package:cms/components/task-data.dart';
import 'package:cms/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigation extends StatelessWidget {
  const CustomNavigation(this.onChangedCallback(value));
  final Function onChangedCallback;

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
          GestureDetector(
            child: Icon(
              Icons.list,
              color: Colors.white,
              size: 35.0,
            ),
            onTap: (){
              onChangedCallback(true);
            },
          ),
          SizedBox(
            width: 10.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25.0,
              backgroundImage: Provider.of<TaskData>(context).userPhoto ==
                  ''
                  ? AssetImage('images/profile-img.png')
                  : FileImage( File(Provider.of<TaskData>(context).userPhoto))
              as ImageProvider, // : FileImage() as ImageProvider,
            ),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
