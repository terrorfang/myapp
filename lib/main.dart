import 'package:flutter/material.dart';

void main() {
  //runApp(MyApp());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int questindex = 0;
  int score = 0;

  var questions = [
    {
      'questText': 'What\'s your fav color?',
      'answers': [
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 4},
        {'text': 'Blue', 'score': 3},
        {'text': 'Black', 'score': 2},
      ]
    },
    {
      'questText': 'What\'s your fav pet?',
      'answers': [
        {'text': 'Cat', 'score': 5},
        {'text': 'Rabbit', 'score': 4},
        {'text': 'Dog', 'score': 3},
        {'text': 'Bird', 'score': 2},
      ]
    }
  ];

  answerQuestion(int score) {
    setState(() {
      questindex = questindex + 1;
      this.score = this.score + score;
    });
    // print(questindex);
    print(this.score);
  }

  resetQuest() {
    setState(() {
      this.questindex = 0;
      this.score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Container(
          child: questindex < questions.length
              ? Quiz(
                  questions: questions,
                  questindex: questindex,
                  answerQuestion: answerQuestion,
                )
              : Result(
                  score: score,
                  resetQuest: resetQuest,
                ),
          width: double.infinity,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  const Quiz(
      {Key key,
      @required this.questions,
      @required this.questindex,
      @required this.answerQuestion})
      : super(key: key);

  final List<Map<String, Object>> questions;
  final int questindex;
  final Function answerQuestion;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        questions[questindex]['questText'],
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      ...(questions[questindex]['answers'] as List<Map<String, Object>>)
          .map((answer) {
        return Container(
          child: RaisedButton(
            onPressed: () {
              answerQuestion(answer['score']);
            },
            child: Text(answer['text']),
            color: Colors.amber,
            textColor: Colors.white,
          ),
          width: double.infinity,
          margin: EdgeInsets.only(left: 10, right: 10),
        );
      })
    ]);
  }
}

class Result extends StatelessWidget {
  const Result({Key key, @required this.score, @required this.resetQuest})
      : super(key: key);

  final int score;
  final Function resetQuest;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Your Score',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$score Scores',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        RaisedButton(
          onPressed: resetQuest,
          child: Text('Reset'),
        )
      ],
    );
  }
}
