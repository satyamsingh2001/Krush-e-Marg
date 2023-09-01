import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/welcomeScreen.dart';
import '../colors/colors_const.dart';
import '../views/bottom_nav_bar/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), () async {
        final prefs = await SharedPreferences.getInstance();
        final userid=prefs.getString("userId");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => userid==null?const WelcomeScreen():const DashBoardScreenMain(currentIndex: 0,)), //OnBoarding
        );
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: AppColors.white10,
        body: Center(
          child: Image.asset('assets/images/applogo.png',height: 150,width: 150,),
        ),
      ),
    );
  }
}