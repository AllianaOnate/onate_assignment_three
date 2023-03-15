import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("BULOHATON",
          style: TextStyle(
              color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFF989E6A),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              title: Text("About Us",
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF989E6A),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text("In 2023, a mobile application was created called Bulohaton. You might wonder why it's named this way. The application's maker is from Mindanao and is a Visayan. Additionally, when Bulohaton is translated into English, it means work. This application allows users to list their tasks or work. Furthermore, the maker has a lot on her plate academically, but she tends to forget some tasks that need to be accomplished. As a consequence, she lists down all her tasks in the Bulohaton application to prevent things from getting more complicated and to ensure that all her tasks are accomplished.",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/bulohaton_logo.png"),
                ),
              ),
              alignment: Alignment.bottomCenter,
              height: 200,
              width: 200,
            )
          ],
        ),
      ),
    );
  }
}
