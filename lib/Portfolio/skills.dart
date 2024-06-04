import 'package:flutter/material.dart';

class Skills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MY SKILLS",
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
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/skillbackground.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: <Widget>[
                  SkillItem(
                    imagePath: 'logos/1.png',
                    skillName: 'C++',
                    borderColor: Colors.greenAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/2.png',
                    skillName: 'Python',
                    borderColor: Colors.redAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/3.png',
                    skillName: 'Dart',
                    borderColor: Colors.blueAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/4.png',
                    skillName: 'HTML',
                    borderColor: Colors.redAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/5.png',
                    skillName: 'CSS',
                    borderColor: Colors.blueAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/6.png',
                    skillName: 'JavaScript',
                    borderColor: Colors.greenAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/12.png',
                    skillName: 'Flutter',
                    borderColor: Colors.blueAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/7.png',
                    skillName: 'Bootstrap',
                    borderColor: Colors.greenAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/9.png',
                    skillName: 'Firebase',
                    borderColor: Colors.redAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/8.png',
                    skillName: 'Django',
                    borderColor: Colors.greenAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/10.png',
                    skillName: 'PostgreSQL',
                    borderColor: Colors.redAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/11.png',
                    skillName: 'Cloud',
                    borderColor: Colors.blueAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/13.png',
                    skillName: 'Arduino',
                    borderColor: Colors.redAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/14.png',
                    skillName: 'Data',
                    borderColor: Colors.blueAccent,
                  ),
                  SkillItem(
                    imagePath: 'logos/15.png',
                    skillName: 'AI',
                    borderColor: Colors.greenAccent,
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SkillItem extends StatelessWidget {
  final String imagePath;
  final String skillName;
  final Color borderColor;

  const SkillItem({
    required this.imagePath,
    required this.skillName,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Image.asset(
            imagePath,
            height: 80.0,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          skillName,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Sniglet",
            fontSize: 17,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
