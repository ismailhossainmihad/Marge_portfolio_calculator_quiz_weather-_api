import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WorkExperiencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Work Experience",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.tealAccent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.tealAccent, Colors.lightBlueAccent],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildIntroText(),
              SizedBox(height: 30),
              _buildExperienceCard(
                context,
                icon: FontAwesomeIcons.code,
                title: "OpenGenus Foundation",
                subtitle:
                    "Data Structures and Algorithms Developer Intern\n(May 2020 - present)",
                description: "- Contributing to open-source projects\n"
                    "- Writing technical articles",
              ),
              SizedBox(height: 30),
              _buildExperienceCard(
                context,
                icon: FontAwesomeIcons.bullhorn,
                title: "Widhya",
                subtitle: "Mission Advocate\n(June 2020 - present)",
                description: "- Creating content for Missions\n"
                    "- Building communities and outreach\n"
                    "- Participating in decision making",
              ),
              SizedBox(height: 30),
              _buildExperienceCard(
                context,
                icon: FontAwesomeIcons.chartLine,
                title: "Wealthy Waste",
                subtitle:
                    "Data Analytics & Research Intern\n(May 2020 - June 2020)",
                description: "- Performing data analysis\n"
                    "- Statistical analysis and correlation\n"
                    "- Preparing research findings",
              ),
              SizedBox(height: 30),
              _buildExperienceCard(
                context,
                icon: FontAwesomeIcons.pen,
                title: "GeeksForGeeks",
                subtitle:
                    "Technical Content Writer Intern\n(May 2020 - present)",
                description: "- Writing technical articles\n"
                    "- Editing and enhancing existing content",
              ),
              SizedBox(height: 30),
              _buildExperienceCard(
                context,
                icon: FontAwesomeIcons.userGraduate,
                title: "IncubateIND",
                subtitle: "Fellow\n(June 2020 - present)",
                description:
                    "Technology fellowship program focusing on skill development through mentorship by industry experts.",
              ),
              SizedBox(height: 30),
              _buildExperienceCard(
                context,
                icon: FontAwesomeIcons.projectDiagram,
                title: "Lets Upgrade",
                subtitle: "Project Manager and Mentor\n(July 2020 - present)",
                description:
                    "Managing and mentoring the 'Algorithmic Treasure' project, aiming to provide helpful coding resources and explanations.",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroText() {
    return Center(
      child: Text(
        "Diverse experience in startups, communities, and innovative strategies.",
        style: TextStyle(
          fontSize: 18,
          fontFamily: "Montserrat",
          color: Colors.white,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildExperienceCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required String description}) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(icon, color: Colors.tealAccent.shade700, size: 30),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 22,
                      color: Colors.teal.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                color: Colors.teal.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 15),
            Text(
              description,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                color: Colors.grey.shade800,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
