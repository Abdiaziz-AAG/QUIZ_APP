import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, Object>> questions = [
    {
      'questionText': '1. Waa maxay caasimada Soomaaliya?',
      'answers': [
        {'text': 'Mogadishu', 'score': 1},
        {'text': 'Hargeisa', 'score': 0},
        {'text': 'Kismayo', 'score': 0},
        {'text': 'Garowe', 'score': 0},
      ],
    },
    {
      'questionText': '2. Waa maxay caasimada kenya?',
      'answers': [
        {'text': 'Mogadishu', 'score': 0},
        {'text': 'Kenya', 'score': 0},
        {'text': 'Nairobi', 'score': 1},
        {'text': 'adis ababa', 'score': 0},
      ],
    },
    {
      'questionText': '3. Waa maxay midabka badda?',
      'answers': [
        {'text': 'Cagaar', 'score': 0},
        {'text': 'Buluug', 'score': 1},
        {'text': 'Jaalle', 'score': 0},
        {'text': 'Madow', 'score': 0},
      ],
    },
    {
      'questionText': '4. Waa maxay caasimada Turkey?',
      'answers': [
        {'text': 'Mogadishu', 'score': 0},
        {'text': 'Kenya', 'score': 0},
        {'text': 'Nairobi', 'score': 0},
        {'text': 'Ankara', 'score': 1},
      ],
    },
    {
      'questionText': '5. Waa maxay caasimada ethopia?',
      'answers': [
        {'text': 'Mogadishu', 'score': 0},
        {'text': 'Kenya', 'score': 0},
        {'text': 'Nairobi', 'score': 0},
        {'text': 'adis ababa', 'score': 1},
      ],
    },
  ];

  int questionIndex = 0;
  int totalScore = 0;

  void answerQuestion(int score) {
    setState(() {
      totalScore += score;
      questionIndex++;
    });
  }

  void resetQuiz() {
    setState(() {
      questionIndex = 0;
      totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: questionIndex < questions.length
          ? Quiz(
              questions: questions,
              answerQuestion: answerQuestion,
              questionIndex: questionIndex,
            )
          : Result(totalScore, resetQuiz),
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          questions[questionIndex]['questionText'] as String,
          style: TextStyle(fontSize: 24),
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return ElevatedButton(
            onPressed: () => answerQuestion(answer['score']),
            child: Text(answer['text'] as String),
          );
        }).toList(),
      ],
    );
  }
}

class Result extends StatelessWidget {
  final int totalScore;
  final VoidCallback resetQuiz;

  Result(this.totalScore, this.resetQuiz);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Quiz Finished! Your Score: $totalScore %5',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: resetQuiz,
            child: Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}
