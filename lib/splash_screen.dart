import 'package:Bulohaton/add_update_page.dart';
import 'package:Bulohaton/home_page.dart';
import 'package:Bulohaton/login_page.dart';
import 'package:Bulohaton/signup_page.dart';
import 'package:Bulohaton/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network("https://assets9.lottiefiles.com/packages/lf20_niyfyoqs.json",
          controller: _controller,
          onLoaded: (compos){
            _controller
            ..duration = compos.duration
            ..forward().then((value) {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> LoginPage()              ));
            });
          }),
          //Center(
            //child: Text("to your tasks"),
          //),
        ],
      ),
    );
  }
}
