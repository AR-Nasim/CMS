import 'dart:ui';

import 'package:cms/screens/welcome-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  static String id="onboarding_screen";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        'Easy To Organise your Classroom',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF145DA0),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image(image: AssetImage('images/seven.webp'),),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Upload Files',
                      style: TextStyle(
                        color: Color(0xFF145DA0),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 35.0, bottom: 18.0),
                      child: Image(image: AssetImage('images/second.webp'),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0, right: 35.0,top: 18.0),
                      child: Text(
                        'No need to upload same file for multiple class. In one tap you can share all groups together',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF145DA0),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Classwork',
                      style: TextStyle(
                        color: Color(0xFF145DA0),
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 18.0),
                      child: Image(image: AssetImage('images/third.webp'),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0, right: 35.0,top: 18.0),
                      child: Text(
                        "You can add classwork for any sub groups as reminder and can delete the classwork when it's done.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF145DA0),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.92),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only (left: 28.0),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0xFF145DA0),
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: WormEffect(
                        dotColor:  Colors.black54,
                        activeDotColor:  Color(0xFF145DA0)
                    ),
                ),
                onLastPage ?
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, WelcomePage.id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 28.0),
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: Color(0xFF145DA0),
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                )
                    : GestureDetector(
                  onTap: () {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 28.0),
                    child: Text(
                      'Next',
                      style: TextStyle(
                        color: Color(0xFF145DA0),
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
