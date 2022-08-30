import 'package:cms/student-screens/quiz-question.dart';

class QuestionBrain {
  int _questionNumber = 0;
  final List<Question> _questions = [
    Question(questionText: 'Some cats are actually allergic to humans', answers: true),
    Question(questionText: 'You can lead a cow down stairs but not up stairs.', answers: false),
    Question(
        questionText: 'Approximately one quarter of human bones are in the feet.',
        answers: true),
    Question(questionText: 'A slug\'s blood is green.', answers: true),
    Question(questionText: 'Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', answers: true),
    Question(questionText: 'It is illegal to pee in the Ocean in Portugal.', answers: true),
    Question(
        questionText: 'No piece of square dry paper can be folded in half more than 7 times.',
        answers: false),
    Question(
        questionText: 'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        answers: true),
    Question(
        questionText: 'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        answers: false),
    Question(
        questionText: 'The total surface area of two human lungs is approximately 70 square metres.',
        answers: true),
    Question(questionText: 'Google was originally called \"Backrub\".', answers: true),
    Question(
        questionText: 'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        answers: true),
    Question(
        questionText: 'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        answers: true),
  ];
  bool nextQuestion(){
    if(_questionNumber < _questions.length - 1){
      _questionNumber++;
      return true;
    }
    return false;
  }
  String getQuestion(){
    return _questions[_questionNumber].questionText;
  }
  bool getAnswer(){
    return _questions[_questionNumber].answers;
  }
  void reset(){
    _questionNumber=0;
  }
}
