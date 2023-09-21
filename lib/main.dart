import 'dart:async';

import 'package:fino_wise/Core/Utils/image_constant.dart';
import 'package:fino_wise/Persistence/Dashboard_screen.dart';
import 'package:fino_wise/Persistence/Signin_screen.dart';
import 'package:fino_wise/Widgets/custom_imageview.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fino_wise/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        checkCondition();
        // Navigator.push(
        //     context,
        //     PageTransition(
        //         type: PageTransitionType.fade, child: const SigninScreen()));
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

  void callApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLogin", true);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const DashboardScreen()));
  }

  void checkCondition() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isLogin = sharedPreferences.getBool("isLogin");

    print("===>IS LOGIN=>" + isLogin.toString());

    if (isLogin != null) {
      if (isLogin) {
        callApi();
      } else {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: const SigninScreen()));
      }
    } else {
      print("====LOGIN ELSE");
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade, child: const SigninScreen()));
      // if(mounted){
      //
      // }
      // Navigator.of(context, rootNavigator: true)
      //     .push(MaterialPageRoute(builder: (context) => SigninScreen()));
    }
  }
}
