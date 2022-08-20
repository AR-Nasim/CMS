
import 'dart:ui';
import 'package:flutter/material.dart';

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
            child:  Padding(
              padding: EdgeInsets.all(7.0),
              child: Text('CMS',
              style: TextStyle(fontSize: 26.0,color: Colors.white, fontWeight: FontWeight.bold),),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
