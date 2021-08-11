import 'package:flutter/material.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:mylamsy/controller/auth_Api.dart';
import 'package:mylamsy/screen/all_auth_screens/register_screen.dart';
import 'package:mylamsy/style/SimilarWidgets.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Authentication auth;
  bool _isLoggedIn = false;
  Map userProfile;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
 // final facebookLogin = FacebookLogin();
  final _loginKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    auth = Authentication();
    super.initState();
  }

 /* _logout() {
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _loginKey,
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/login_cover.png'),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),

                    // logo image
                    Container(
                      height: MediaQuery.of(context).size.height*0.28,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/logo.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    // user name
                    _userEmailTextField(),
                    SizedBox(height: 25),

                    // password
                    _userPasswordTextField(),
                    SizedBox(
                      height: 35.0,
                    ),

                    // login button
                    _materialButtonLogin(LocaleKeys.login.tr(), CustomColors.Primary,
                        () {
                      if (_loginKey.currentState.validate()) {
                        auth
                            .logIn(
                          context,
                          _emailController.text,
                          _passwordController.text,
                        )
                            .then((Val) {
                          if (Val == 'ok') {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(2),
                              ),
                            );
                          } else {
                            showDialogWidget(
                                LocaleKeys.login_error.tr(),
                                context);
                          }
                        });
                      }
                    }),
                    SizedBox(height: 25),
                    // facebook Login Button
                   /* _materialButtonLogin(
                        'تسجيل الدخول بالفيس بوك', CustomColors.Facebook,
                        () async {
                      final facebookLogin = FacebookLogin();
                      final result = await facebookLogin.logIn(['email']);
                      print(result.errorMessage);
                      switch (result.status) {
                        case FacebookLoginStatus.loggedIn:
                          print('is loged in');
                          final token = result.accessToken.token;
                          await auth
                              .logInWithFacebook(context, token)
                              .then((Val) {
                            if (Val == "ok") {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(2),
                                ),
                              );

                              SnackBar mySnakBar =
                                  SnackBar(content: Text('شكرا لك'));
                              Scaffold.of(context).showSnackBar(mySnakBar);
                            } else {
                              showDialogWidget(
                                  "يوجد خضاء فى تسجيل الدخول باستحدام الفيس",
                                  context);
                            }
                          });

                          setState(() {
                            _isLoggedIn = true;
                          });
                          break;

                        case FacebookLoginStatus.cancelledByUser:
                          print('you close it');

                          setState(() => _isLoggedIn = false);
                          break;
                        case FacebookLoginStatus.error:
                          print('have an erorr');
                          setState(() => _isLoggedIn = false);
                          break;
                      }
                    }),*/
                    SizedBox(height: 25),

                    // google login button
                    SizedBox(height: 40),
                    // sign in button
                    _materialButtonLogin(
                        LocaleKeys.create_account.tr(), CustomColors.SecondaryHover, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userEmailTextField() {
    return TextFormField(
      controller: _emailController,
      autofocus: false,
      onChanged: (value) {},
      validator: (val) {
        if (val.isEmpty) {
          return LocaleKeys.empty_field.tr();
        }
        return null;
      },
      cursorColor: Colors.black,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: LocaleKeys.user_name.tr(),
      ),
    );
  }

  Widget _userPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      autofocus: false,
      obscureText: true,
      onChanged: (value) {},
      validator: (val) {
        if (val.isEmpty) {
          return LocaleKeys.empty_field.tr();
        }

        return null;
      },
      cursorColor: Colors.black,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        hintText: LocaleKeys.password.tr(),
      ),
    );
  }

  Widget _materialButtonLogin(String title, Color color, Function onPressed) {
    return Material(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      elevation: 1.0,
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 200.0,
        height: 42.0,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
