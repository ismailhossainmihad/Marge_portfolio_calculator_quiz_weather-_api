import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Portfolio/aboutme.dart';
import 'Portfolio/educationPage.dart';
import 'Portfolio/workExperience.dart';
import 'Portfolio/skills.dart';
import 'Portfolio/projects.dart';
import 'Portfolio/blog.dart'; // Import the new Blog page
// ignore: depend_on_referenced_packages
import 'package:fin/Calculator/CalculatorScreen.dart';
import 'package:fin/QUIZ/QuizScreen.dart';
import 'package:fin/Weather/Weather.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _checkLoginStatus();
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('theme');
    setState(() {
      if (theme == 'dark') {
        _themeMode = ThemeMode.dark;
      } else if (theme == 'light') {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.system;
      }
    });
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    setState(() {
      _isLoggedIn = isLoggedIn ?? false;
    });
  }

  void _toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
        prefs.setString('theme', 'dark');
      } else {
        _themeMode = ThemeMode.light;
        prefs.setString('theme', 'light');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      themeMode: _themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: _isLoggedIn ? '/main' : '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/main': (context) =>
            MainScreen(toggleTheme: _toggleTheme, themeMode: _themeMode),
        '/aboutMe': (context) => AboutMe(),
        '/education': (context) => EducationPage(),
        '/workexperience': (context) => WorkExperiencePage(),
        '/skills': (context) => Skills(),
        '/project': (context) => MobileApps(),
        '/calculator': (context) => CalculatorScreen(),
        '/quiz': (context) => const ModeSelectionScreen(),
        '/weather': (context) => WeatherWidget(),
        '/blog': (context) => BlogPage(), // Add the new Blog route
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_formKey.currentState!.validate()) {
      // Save login status to shared preferences
      prefs.setBool('isLoggedIn', true);

      // Navigate to the main application
      Navigator.pushReplacementNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100),
            Text(
              "Welcome Back!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Comfortaa',
              ),
            ),
            SizedBox(height: 30),
            Card(
              color: Colors.white.withOpacity(0.1),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.0,
                            vertical: 15.0,
                          ),
                          backgroundColor: Color.fromARGB(227, 216, 96, 44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Implement forgot password functionality
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Color.fromRGBO(227, 216, 96, 44)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final ThemeMode themeMode;

  MainScreen({required this.toggleTheme, required this.themeMode});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    PortfolioScreen(),
    CalculatorScreen(),
    ModeSelectionScreen(),
    WeatherWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Portfolio",
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        actions: [
          IconButton(
            icon: Icon(widget.themeMode == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Navigation Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.developer_mode_sharp),
              title: Text('Portfolio'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Calculator'),
              onTap: () {
                Navigator.pushNamed(context, '/calculator');
              },
            ),
            ListTile(
              leading: Icon(Icons.quiz_outlined),
              title: Text('Quiz'),
              onTap: () {
                Navigator.pushNamed(context, '/quiz');
              },
            ),
            ListTile(
              leading: Icon(Icons.sunny_snowing),
              title: Text('Weather'),
              onTap: () {
                Navigator.pushNamed(context, '/weather');
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black, // Change the background color here
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.developer_mode_sharp),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny_snowing),
            label: 'Weather',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal, // Change the selected item color here
        unselectedItemColor:
            Colors.white70, // Change the unselected item color here
        onTap: _onItemTapped,
      ),
    );
  }
}

class PortfolioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              "Ismail Hossain Mihad",
              style: TextStyle(
                fontFamily: 'Sniglet',
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "A Talented Flutter App Developer",
              style: TextStyle(
                fontFamily: 'Caveat Brush',
                fontSize: 18,
                color: Colors.white,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: <Widget>[
                _buildGridTile(
                  context,
                  icon: Icons.face_outlined,
                  title: "About Me",
                  gradientColors: [Colors.red, Colors.pinkAccent],
                  route: '/aboutMe',
                ),
                _buildGridTile(
                  context,
                  icon: Icons.school_outlined,
                  title: "My Education",
                  gradientColors: [Colors.orange, Colors.deepOrangeAccent],
                  route: '/education',
                ),
                _buildGridTile(
                  context,
                  icon: Icons.work_outline,
                  title: "Experience",
                  gradientColors: [Colors.green, Colors.lightGreenAccent],
                  route: '/workexperience',
                ),
                _buildGridTile(
                  context,
                  icon: Icons.code_outlined,
                  title: "My Skills",
                  gradientColors: [Colors.purple, Colors.deepPurpleAccent],
                  route: '/skills',
                ),
                _buildGridTile(
                  context,
                  icon: Icons.dashboard_outlined,
                  title: "My Project",
                  gradientColors: [Colors.teal, Colors.tealAccent],
                  route: '/project',
                ),
                _buildGridTile(
                  context,
                  icon: Icons.book_outlined, // Icon for the Blog
                  title: "Blog",
                  gradientColors: [Colors.blue, Colors.lightBlueAccent],
                  route: '/blog',
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.twitter),
                  color: Colors.lightBlue,
                  iconSize: 40,
                  onPressed: twitter_url,
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.github),
                  color: Colors.white,
                  iconSize: 40,
                  onPressed: github_url,
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.linkedin),
                  color: Colors.indigoAccent,
                  iconSize: 43,
                  onPressed: linked_in_url,
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.quora),
                  color: Colors.red,
                  iconSize: 43,
                  onPressed: quora_url,
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.medium),
                  color: Colors.white,
                  iconSize: 43,
                  onPressed: medium_url,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGridTile(BuildContext context,
      {required IconData icon,
      required String title,
      required List<Color> gradientColors,
      required String route}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: EdgeInsets.all(20.0),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 50,
            ),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "Comfortaa",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

linked_in_url() async {
  const url = 'https://www.linkedin.com/in/ismailhossainmihad/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

twitter_url() async {
  const url = 'https://x.com/ismail_mihad';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

github_url() async {
  const url = 'https://github.com/ismailhossainmihad';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

quora_url() async {
  const url = 'https://www.quora.com/profile/Ismail-Hossain-Mihad';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

medium_url() async {
  const url = 'https://medium.com/@ismailhossainmihad';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
