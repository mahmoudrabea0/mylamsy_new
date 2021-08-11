import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylamsy/screen/all_auth_screens/login_screen.dart';
import 'package:mylamsy/screen/main_screen.dart';
import 'package:mylamsy/utilities/preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:mylamsy/screen/appbar/notification_screen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
@override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SplashScreen(
        seconds: 2,
        imageBackground: AssetImage(
          'images/splash_cover.png',
        ),
        image: Image.asset(
          'images/logo.png',
          alignment: Alignment.bottomCenter,
        ),
        loaderColor: Colors.transparent,
        photoSize: 200.0,
        navigateAfterSeconds: FutureBuilder(
            future: Preference.getId(),

            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MainScreen(2);
              }
              return LoginScreen();
            }),
      ),
    );
  }
}
