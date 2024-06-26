import 'dart:async';
import 'package:checkmate/Pages/home_screen.dart';
import 'package:flutter/material.dart';
 

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer ile 2 saniye geciktirilmiş işlem
    Timer(Duration(seconds: 2), () {
      // Navigator ile ana ekranı başlatma
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Burada başlangıç ekranının tasarımı döndürülüyor
    return Scaffold(
      body: Center(
        child: Image.asset("images/logo.png"), // Launch screen içeriği
      ),
    );
  }
}
