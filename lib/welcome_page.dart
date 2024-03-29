import 'package:Bulohaton/home_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {

  String email;
  var data;
  var time;
  var ref;

  WelcomePage({Key? key, required this.email, this.data, this.time, this.ref}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: w,
            height: h*0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/sign_header.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: h*0.16),
                CircleAvatar(
                  backgroundColor: Colors.pink,
                  radius: 40,
                  backgroundImage: AssetImage(
                      "assets/profile_icon_white.png"
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: w,
            margin: EdgeInsets.only(left: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
            SizedBox(height: 50),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Container(
              width: w*0.5,
              height: h*0.08,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage("assets/login_button.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center (
                child: Text("Get started",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
