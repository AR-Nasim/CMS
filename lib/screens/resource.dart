import 'package:cms/components/custom-drawer.dart';
import 'package:cms/components/navigation.dart';
import 'package:cms/screens/group-screen.dart';
import 'package:cms/screens/subgroup-screen.dart';
import 'package:cms/screens/video.resource.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image-resource.dart';

class Resources extends StatefulWidget {
  static String id="resources";

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: _globalKey,
        drawer:CustomDrawer() ,
        body: ColorfulSafeArea(
          color: Color(0xFF13192F),
          child: Column(
            children: [
              CustomNavigation("Resources",(value){
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
                    Positioned(
                      child: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, SubGroups.id);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 7.0),
                                    child: Text(
                                      "Groups",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 5.0),
                                  child: Text(
                                    "Resources",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:BorderSide(color: Colors.black,width: 3.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 45.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, ImageResources.id);
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Images',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(0, 2),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child:
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, top: 45.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, VideoResources.id);
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Videos',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 45.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, ImageResources.id);
                          },
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Pdfs',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(0, 2),
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child:
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, bottom: 45.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Links',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}