import 'package:flutter/material.dart';
import 'package:poo/quiz_brain.dart';


QuizBrain quiz = QuizBrain();
List<Widget> scoreKeeper = [];
int score = 0;

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Wrap(
          children: scoreKeeper,
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quiz.getQuestionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),Expanded(
            child: quiz.lastQuestion() ? Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)
                ),
                child: Text(
                  'Empezar de Nuevo',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    quiz.restartQuestions();
                    scoreKeeper = [];
                    score = 0;
                  });
                },
              ),
            ) : Icon(Icons.repeat, color: Colors.white24,)
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)
              ),
              child: Text(
                'Verdadero',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                if (!quiz.lastQuestion()) {
                  questionValidator(true);
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.red)
              ),
              child: Text(
                'Falso',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                if (!quiz.lastQuestion()) {
                  questionValidator(false);
                }
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
      ],
    );
  }

  void questionValidator(bool selected) {
    bool correctAnswer = quiz.getAnswer;
    const iconSize = 31.0;
    if (correctAnswer == selected){
      scoreKeeper.add(Icon(Icons.check, color: Colors.green, size: iconSize,));
      score++;
    }
    else
    {
      scoreKeeper.add(Icon(Icons.close, color: Colors.redAccent, size: iconSize,));
    }
    setState(() {
      quiz.nextQuestion();
      if (quiz.lastQuestion()){
      _showMyDialog();
      }
    });
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¡Felicidades!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Has completado el juego'),
                Text('Tu puntuación es de ${score} ptos'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}