import 'package:Bulohaton/login_page.dart';
import 'package:Bulohaton/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user){
    if(user==null){
      print("Login Page");
      Get.offAll(()=>LoginPage());
    } else{
      Get.offAll(()=>WelcomePage(email:user.email!));
    }
  }

  void register(String email, password) async {
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch(e){
      Get.snackbar("About User", "User Message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Account created failed",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        messageText: Text(
          e.toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        )
      );
    }
  }
  void login(String email, password) async {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch(e){
      Get.snackbar("About Login", "Login Message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Login failed",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          )
      );
    }
  }
  void logOut()async{
    await auth.signOut();
  }
}