import 'package:cms/student-screens/quiz-page.dart';
import 'package:cms/student-screens/quizBrain.dart';
import 'package:flutter/material.dart';


QuestionBrain questionBrain = QuestionBrain();

class Quiz extends StatefulWidget {
  static String id = 'quiz';

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        ),
      ),
    );
  }
}



