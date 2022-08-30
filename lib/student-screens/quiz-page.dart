import 'package:cms/screens/group-info.dart';
import 'package:cms/student-screens/quiz.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizPage extends StatefulWidget {
  static String id = 'quiz-page';
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];
  void displayAnswer(bool ans) {
    bool correctAns = questionBrain.getAnswer();
    setState(() {
      if (ans == correctAns) {
        scorekeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scorekeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
      bool res = questionBrain.nextQuestion();
      if (!res) {
        questionBrain.reset();
        scorekeeper = [];
        Alert(
            context: context,
            title: 'Finished!',
            desc: 'You\'ve reached the end of the quiz.',
            buttons: [
              DialogButton(
                child:const Text(
                  "Start Again",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Quiz.id);
                },
                color: Colors.red,
              ),
              DialogButton(
                child:const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.green,
                onPressed: () => Navigator.pushNamed(context, GroupInfo.id),
              ),
            ]
        ).show();

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                displayAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                displayAnswer(false);
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}