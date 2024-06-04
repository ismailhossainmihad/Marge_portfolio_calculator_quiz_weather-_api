// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MY EDUCATION",
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
                image: AssetImage("images/education_background.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: const <Widget>[
              EducationSection(
                sectionTitle: "Primary School",
                items: [
                  EducationItem(
                    icon: FontAwesomeIcons.child,
                    title:
                        "Ghatail Cantonment Board High School, Ghatail\n(2005-2011)",
                    description:
                        "I started my educational journey here, excelling in various subjects and developing a love for learning.",
                    certificateImage:
                        "images/certificates/primary_certificate.png",
                  ),
                ],
              ),
              EducationSection(
                sectionTitle: "High School",
                items: [
                  EducationItem(
                    icon: FontAwesomeIcons.school,
                    title: "Sristy Academic School\n(2011-2018)",
                    description:
                        "I completed my secondary education here, majoring in Science and consistently ranking among the top students.",
                    certificateImage:
                        "images/certificates/high_school_certificate.png",
                  ),
                ],
              ),
              EducationSection(
                sectionTitle: "College",
                items: [
                  EducationItem(
                    icon: FontAwesomeIcons.building,
                    title: "Sristy College Of Tangail\n(2012-2014)",
                    description:
                        "I pursued higher secondary education in Science, participating in various extracurricular activities and maintaining excellent academic performance.",
                    certificateImage:
                        "images/certificates/college_certificate.png",
                  ),
                ],
              ),
              EducationSection(
                sectionTitle: "University",
                items: [
                  EducationItem(
                    icon: FontAwesomeIcons.university,
                    title: "Daffodil International University\n(2020-2023)",
                    description:
                        "Currently an undergraduate majoring in CSE. I focus on product development and deployment in distributed systems, honing my skills as a junior developer.",
                    certificateImage: "images/o2.png",
                  ),
                ],
              ),
              SizedBox(
                height: 80,
                width: 260,
                child: Divider(
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EducationSection extends StatelessWidget {
  final String sectionTitle;
  final List<EducationItem> items;

  const EducationSection({
    required this.sectionTitle,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            sectionTitle,
            style: const TextStyle(
              fontFamily: 'Sniglet',
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...items,
      ],
    );
  }
}

class EducationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String certificateImage; // Add this field for certificate images

  const EducationItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.certificateImage, // Add this parameter
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Center(
            child: IconButton(
              icon: FaIcon(icon),
              iconSize: 80,
              color: Colors.white,
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Sniglet',
                fontSize: 27,
                color: Colors.white,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              description,
              style: const TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 17,
                color: Colors.white,
                letterSpacing: 2.0,
                height: 2,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 20.0), // Increased vertical padding
            child: Image.asset(
              certificateImage,
              height: 250, // Increased height
              width: 250, // Increased width
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
