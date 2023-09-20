import 'dart:async';

import 'package:fino_wise/Core/Utils/image_constant.dart';
import 'package:fino_wise/Persistence/Dashboard_screen.dart';
import 'package:fino_wise/Widgets/custom_imageview.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff00C8BC),
      statusBarBrightness: Brightness.light,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinoWise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff00C8BC)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    setState(() {
      Timer(const Duration(seconds: 2), () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: const DashboardScreen()));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff00C8BC),
      body: Center(
        child: CustomImageView(
          margin: EdgeInsets.only(bottom: h * 0.06),
          imagePath: ImageConstant.icsplashlogo,
          scale: 3.7,
        ),
      ),
    );
  }
}
