import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ModeSelectionScreen(),
    );
  }
}

class ModeSelectionScreen extends StatelessWidget {
  const ModeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Mode'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RedesignedButton(
              text: 'Practice',
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuizScreen(mode: 'Practice'),
                  ),
                );
              },
            ),
            RedesignedButton(
              text: 'Timed',
              color: Colors.orange,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EnterNameScreen(),
                  ),
                );
              },
            ),
            RedesignedButton(
              text: 'Leaderboard',
              color: Colors.green,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LeaderboardScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RedesignedButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const RedesignedButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      width: 200.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 5.0,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}

class EnterNameScreen extends StatefulWidget {
  const EnterNameScreen({super.key});

  @override
  EnterNameScreenState createState() => EnterNameScreenState();
}

class EnterNameScreenState extends State<EnterNameScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Enter your name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizScreen(
                        mode: 'Timed',
                        name: _nameController.text,
                      ),
                    ),
                  );
                }
              },
              child: const Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final String mode;
  final String? name;
  const QuizScreen({super.key, required this.mode, this.name});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  SharedPreferences? sharedPreferences;
  int highestScore = 0;
  int quizNumber = 1;
  int questionIndex = 0;
  int score = 0;
  bool isAnswered = false;
  late bool isTimedMode;

  int quizTimeInSeconds = 15 * 60; // 15 minutes in seconds
  int timeRemaining = 15 * 60; // Initially set to quiz time

  List<String> questions = [
    "Who is the creator of Flutter?",
    "What is the capital of France?",
    "Which animal has the largest eyes?",
    "How many continents are there on Earth?",
    "What is the rarest blood type?",
    "What is cynophobia the fear of?",
    "Which country consumes the most chocolate per capita?",
    "What is the fastest land animal?",
    "What is the largest freshwater lake in the world?",
    "What planet has the most moons?",
    "What is the hardest natural substance on Earth?",
    "Which country invented tea?",
    "Who was the first woman to win a Nobel Prize?",
    "Which planet is the hottest in the solar system?",
    "Which country produces the most coffee in the world?",
    "What is the largest type of penguin?",
    "How many squares are on a chess board?",
    "How many wives did King Henry VIII have?",
    "What does the word 'emoji' literally mean in Japanese?",
    "Which country has won most FIFA world cup football trophies?",
    "Which fruit inspired Newton to think about gravity?",
    "What is the most popular sport in the world?",
    "How many years are there in one millennium?",
    "What is the main component of the sun?",
    "How many bones do sharks have in their bodies?",
    "Where are the smallest bones in human body located?",
    "Which country has not adopted the metric system?",
    "How long can snakes hold their breath?",
    "How many symphonies did Beethoven compose?",
    "Where would you find the sea of tranquility?"
  ];

  List<List<String>> options = [
    ["Mark Zuckerberg", "Steve Jobs", "Bill Gates", "Google founders"],
    ["Nice", "Marseille", "Paris", "Lyon"],
    ["Owl", "Giraffe", "Colossal squid", "Horseshoe crab"],
    ["5", "6", "7", "8"],
    ["AB-", "B-", "O-", "A-"],
    ["Dogs", "Darkness", "Clowns", "Dolphins"],
    ["Belgium", "Germany", "Switzerland", "France"],
    ["Fox", "Cheetah", "Peregrine Falcon", "Jaguar"],
    ["Lake Superior", "Lake Baikal", "Lake Victoria", "Lake Titicaca"],
    ["Jupiter", "Saturn", "Uranus", "Neptune"],
    ["Diamond", "Neutronium", "Graphene", "Carbyne"],
    ["India", "Japan", "China", "Sri Lanka"],
    [
      "Marie Curie",
      "Florence Nightingale",
      "Rosalind Franklin",
      "Ada Lovelace"
    ],
    ["Venus", "Mercury", "Mars", "Uranus"],
    ["Brazil", "Vietnam", "Colombia", "Indonesia"],
    ["King penguin", "Emperor penguin", "Little penguin", "African penguin"],
    ["64", "50", "36", "28"],
    ["3", "6", "8", "2"],
    ["Picture character", "Face picture", "Laugh picture", "Emoticon"],
    ["Brazil", "Germany", "Italy", "Uruguay"],
    ["Apple", "Grapes", "Coconut", "Strawberry"],
    ["Football/Soccer", "Cricket", "Hockey", "Basketball"],
    ["1000 years", "500 years", "100 years", "200 years"],
    ["Oxygen", "Hydrogen", "Helium", "Carbon"],
    ["20", "300", "0", "100"],
    ["Eye", "Nose", "Ear", "Brain"],
    ["UK", "USA", "Liberia", "Myanmar"],
    ["1 hour", "20 minutes", "2 hours", "10 minutes"],
    ["3", "2", "7", "9"],
    ["On the moon", "In the Atlantic Ocean", "In Japan", "In France"]
  ];

  List<String> correctAnswers = [
    "Google founders",
    "Paris",
    "Colossal squid",
    "7",
    "AB-",
    "Dogs",
    "Switzerland",
    "Cheetah",
    "Lake Baikal",
    "Saturn",
    "Diamond",
    "China",
    "Marie Curie",
    "Venus",
    "Brazil",
    "Emperor penguin",
    "64",
    "6",
    "Picture character",
    "Brazil",
    "Apple",
    "Football/Soccer",
    "1000 years",
    "Hydrogen",
    "0",
    "Ear",
    "USA",
    "1 hour",
    "9",
    "On the moon"
  ];

  List<String> selectedAnswers = [];

  void shuffleQuestionsAndOptions() {
    List<int> indices = List<int>.generate(questions.length, (index) => index);
    indices.shuffle();

    List<String> shuffledQuestions = [];
    List<List<String>> shuffledOptions = [];
    List<String> shuffledCorrectAnswers = [];

    for (var index in indices) {
      shuffledQuestions.add(questions[index]);
      shuffledOptions.add(options[index]);
      shuffledCorrectAnswers.add(correctAnswers[index]);
    }

    setState(() {
      questions = shuffledQuestions;
      options = shuffledOptions;
      correctAnswers = shuffledCorrectAnswers;
    });
  }

  @override
  void initState() {
    super.initState();
    isTimedMode = widget.mode == 'Timed';
    loadHighestScore();
    shuffleQuestionsAndOptions();

    if (isTimedMode) {
      startTimer();
    }
  }

  Future<void> loadHighestScore() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      highestScore = sharedPreferences?.getInt('highestScore') ?? 0;
    });
  }

  void updateHighestScore(int newScore) async {
    if (newScore > highestScore) {
      setState(() {
        highestScore = newScore;
      });
      await sharedPreferences?.setInt('highestScore', newScore);
    }
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (timeRemaining > 0 && mounted) {
        setState(() {
          timeRemaining--;
        });
        startTimer();
      } else if (timeRemaining == 0) {
        endQuiz();
      }
    });
  }

  void answerQuestion(String selectedAnswer) {
    if (!isAnswered) {
      setState(() {
        selectedAnswers.add(selectedAnswer);
        isAnswered = true;
      });

      if (selectedAnswer == correctAnswers[questionIndex]) {
        score++;
      }

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          questionIndex++;
          isAnswered = false;
        });

        if (questionIndex >= questions.length) {
          endQuiz();
        }
      });
    }
  }

  void endQuiz() {
    if (isTimedMode) {
      saveScoreToLeaderboard();
    }
    updateHighestScore(score);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResultScreen(
          score: score,
          highestScore: highestScore,
          isTimedMode: isTimedMode,
        ),
      ),
    );
  }

  Future<void> saveScoreToLeaderboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> leaderboard = prefs.getStringList('leaderboard') ?? [];
    leaderboard.add('${widget.name}: $score');
    await prefs.setStringList('leaderboard', leaderboard);
  }

  String get timeFormatted {
    int minutes = timeRemaining ~/ 60;
    int seconds = timeRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (questionIndex >= questions.length) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mode == 'Practice' ? 'Practice Quiz' : 'Timed Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isTimedMode)
              Text(
                'Time Remaining: $timeFormatted',
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
            const SizedBox(height: 20),
            Text(
              'Question ${questionIndex + 1}/${questions.length}',
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            Text(
              questions[questionIndex],
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Column(
              children: options[questionIndex].map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ElevatedButton(
                    onPressed: () => answerQuestion(option),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAnswered
                          ? (option == correctAnswers[questionIndex]
                              ? Colors.green
                              : (selectedAnswers.contains(option)
                                  ? Colors.red
                                  : Colors.blue))
                          : Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (isAnswered &&
                            option == correctAnswers[questionIndex])
                          const Icon(Icons.check, color: Colors.white),
                        if (isAnswered &&
                            selectedAnswers.contains(option) &&
                            option != correctAnswers[questionIndex])
                          const Icon(Icons.close, color: Colors.white),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            if (isAnswered)
              Text(
                selectedAnswers.last == correctAnswers[questionIndex]
                    ? 'Correct!'
                    : 'Incorrect! The correct answer is: ${correctAnswers[questionIndex]}',
                style: TextStyle(
                  fontSize: 18,
                  color: selectedAnswers.last == correctAnswers[questionIndex]
                      ? Colors.green
                      : Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int highestScore;
  final bool isTimedMode;

  const QuizResultScreen({
    Key? key,
    required this.score,
    required this.highestScore,
    required this.isTimedMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your Score: $score',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Highest Score: $highestScore',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ModeSelectionScreen(),
                  ),
                );
              },
              child: const Text('Go to Home'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Share.share(
                  'I scored $score on the quiz! Can you beat my score?',
                );
              },
              child: const Text('Share your Score'),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  Future<List<String>> loadLeaderboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('leaderboard') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: FutureBuilder<List<String>>(
        future: loadLeaderboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading leaderboard'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No scores yet. Be the first to take the quiz!'),
            );
          } else {
            List<String> leaderboard = snapshot.data!;
            return ListView.builder(
              itemCount: leaderboard.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    '${index + 1}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  title: Text(
                    leaderboard[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
