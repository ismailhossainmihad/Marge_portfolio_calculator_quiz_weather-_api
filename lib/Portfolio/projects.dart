// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class MobileApps extends StatelessWidget {
  const MobileApps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MY MOBILE APPS",
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/mobileapps.png"), fit: BoxFit.cover),
          ),
          child: Column(
            children: <Widget>[
              _buildProjectCard(
                context,
                icon: FontAwesomeIcons.android,
                title: 'WeatherApp',
                description:
                    'A mobile application that provides real-time weather updates and forecasts.',
                url: 'https://github.com/example/weatherapp',
              ),
              _buildProjectCard(
                context,
                icon: FontAwesomeIcons.mobileAlt,
                title: 'FitnessTracker',
                description:
                    'A mobile application to track your fitness activities, workouts, and progress.',
                url: 'https://github.com/example/fitnesstracker',
              ),
              _buildProjectCard(
                context,
                icon: FontAwesomeIcons.shoppingCart,
                title: 'E-commerce App',
                description:
                    'A mobile application for online shopping with a user-friendly interface and secure payment options.',
                url: 'https://github.com/example/ecommerceapp',
              ),
              _buildProjectCard(
                context,
                icon: FontAwesomeIcons.utensils,
                title: 'RecipeBook',
                description:
                    'A mobile application that provides a collection of recipes with step-by-step instructions and ingredients list.',
                url: 'https://github.com/example/recipebook',
              ),
              _buildProjectCard(
                context,
                icon: FontAwesomeIcons.book,
                title: 'BookReader',
                description:
                    'A mobile application for reading and organizing your digital library of books and articles.',
                url: 'https://github.com/example/bookreader',
              ),
              _buildProjectCard(
                context,
                icon: FontAwesomeIcons.wallet,
                title: 'ExpenseTracker',
                description:
                    'A mobile application to manage and track your daily expenses and budget.',
                url: 'https://github.com/example/expensetracker',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String description,
      required String url}) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.lightBlueAccent,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: 400,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.black,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 0, 20),
                child: ListTile(
                  leading: FaIcon(
                    icon,
                    size: 80,
                    color: Colors.greenAccent,
                  ),
                  title: Text('$title\n',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Sniglet',
                          fontSize: 20)),
                  subtitle: Text(description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Comfortaa",
                      )),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.greenAccent,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextButton(
                      onPressed: () => _launchURL(url),
                      child: const Text('View Project',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Comfortaa",
                          )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
