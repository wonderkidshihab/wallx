import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallx/Core/Utilities/AppRoutes.dart';
import 'package:wallx/Core/Utilities/api_manager.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double width = 20;

  @override
  void initState() {
    initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          width: width,
          duration: Duration(seconds: 2),
          curve: Curves.easeInOut,
          alignment: Alignment.center,
          child: Image.asset("assets/images/preview.png"),
        ),
      ),
    );
  }

  void initAnimation() async {
    ApiManager.init();
    await Future.delayed(Duration(milliseconds: 20));
    setState(() {
      width = MediaQuery.of(context).size.width - 40;
    });
    await Future.delayed(Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.HOME);
  }
}
