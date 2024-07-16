import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio/features/dashboard/views/dashboard2.dart';
import 'package:my_portfolio/features/authentication/views/login_page.dart';
import 'package:my_portfolio/features/onboarding/views/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashLight extends StatefulWidget {
  const SplashLight({super.key});

  @override
  SplashLightState createState() => SplashLightState();
}

class SplashLightState extends State<SplashLight> {
  bool isFirstTime = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkFirstTime();
    checkLoggedIn();
  }

  void checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time') ?? true;
    setState(() {
      isFirstTime = firstTime;
      // Set first_time to false after first app launch
      if (firstTime) {
        prefs.setBool('first_time', false);
      }
    });
  }

  void checkLoggedIn() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Lottie.asset('assets/dark.json'),
          Text(
            'Amaan Ahmad',
            style: GoogleFonts.cinzel(fontSize: 30, color: Colors.white),
          ),
        ],
      ),
      nextScreen: getNextScreen(),
      duration: 1500,
      backgroundColor: Colors.black,
      splashIconSize: 135,
    );
  }

  Widget getNextScreen() {
    if (isFirstTime) {
      return const OnBoard();
    } else {
      if (isLoggedIn && FirebaseAuth.instance.currentUser!.emailVerified) {
        return const ProfileScreen();
      } else {
        return const LoginPage();
      }
    }
  }
}
