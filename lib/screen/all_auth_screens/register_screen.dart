import 'package:flutter/material.dart';
import 'package:mylamsy/controller/auth_Api.dart';
import 'package:mylamsy/screen/all_auth_screens/register_data_screen.dart';
import 'package:mylamsy/style/SimilarWidgets.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Authentication auth;
  TextEditingController _firstController;
  TextEditingController _lastController;
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _conPasswordController;
  final _signUpKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    auth = Authentication();
    _firstController = TextEditingController();
    _lastController = TextEditingController();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _conPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _signUpKey,
        child: ListView(
          children: <Widget>[
            // background image
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
                      height: 30,
                    ),

                    // logo
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .125,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/logo_r.png'),
                            fit: BoxFit.contain),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .0375,
                    ),

                    // userName
                    _materialTextField(LocaleKeys.first_name.tr(), _firstController),
                    SizedBox(height: 25),

                    // lastName
                    _materialTextField(LocaleKeys.last_name.tr(), _lastController),
                    SizedBox(height: 25),

                    // userName
                    _materialTextField(LocaleKeys.user_name.tr(), _nameController),
                    SizedBox(height: 25),

                    // email
                    _materialTextField(LocaleKeys.eamil.tr(), _emailController),
                    SizedBox(height: 25),

                    // password
                    _materialPasswordField(LocaleKeys.pass.tr(), _passwordController),
                    SizedBox(
                      height: 25,
                    ),

                    // password
                    _materialPasswordField(
                        LocaleKeys.confirm_pass.tr(), _conPasswordController),
                    SizedBox(
                      height: 35,
                    ),
                    _materialButtonSignUp(
                      LocaleKeys.create_account.tr(),
                      CustomColors.SecondaryHover,
                      () {
                        if (_signUpKey.currentState.validate()) {
                          if(_passwordController.text != _conPasswordController.text){
                            SnackBar mySnakBar = SnackBar(
                                content: Text(
                                    LocaleKeys.two_pass.tr()));
                            _scaffoldKey.currentState.showSnackBar(mySnakBar);
                            return;
                          }
                          auth.signUpAsClient(
                                  context,
                                  _firstController.text,
                                  _lastController.text,
                                  _nameController.text,
                                  _emailController.text,
                                  _passwordController.text)
                              .then((Val) {
                                print(Val.toString() + "yyyyy");
                                  if (Val["id"] != null) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterDataScreen(),
                                      ),
                                    );
                                    SnackBar mySnakBar = SnackBar(
                                        content: Text(
                                            LocaleKeys.complete_info.tr()));
                                    _scaffoldKey.currentState.showSnackBar(mySnakBar);
                                  } else {
                                    SnackBar mySnakBar = SnackBar(
                                        content: Text(
                                            Val["message"] + Val["data"]['params']));
                                    _scaffoldKey.currentState.showSnackBar(mySnakBar);
                                  }


                          });
                        }
                      },
                    )
                    // material Button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _materialTextField(String title, TextEditingController controller) {
    return TextFormField(
      controller: controller,
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
        hintText: title,
      ),
    );
  }

  Widget _materialPasswordField(
      String title, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      obscureText: true,
      validator: (val) {
        if (val.isEmpty) {
          return LocaleKeys.empty_field.tr();
        }
        return null;
      },
      onChanged: (value) {},
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
        hintText: title,
      ),
    );
  }

  Widget _materialButtonSignUp(String title, Color color, Function onPressed) {
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
//  Material(
//  color: CustomColors.SecondaryHover,
//  borderRadius: BorderRadius.all(Radius.circular(5.0)),
//  elevation: 1.0,
//  child: MaterialButton(
//  onPressed: () {
//  auth
//      .signUpAsClient(
//  _firstController.text,
//  _lastController.text,
//  _nameController.text,
//  _emailController.text,
//  _passwordController.text)
//      .then((Val) {
//  if (Val == "not found") {
//  Navigator.push(
//  context,
//  MaterialPageRoute(
//  builder: (context) => MainScreen(0),
//  ),
//  );
//  } else {
//  showDialogWidget(
//  "incorrect email or password. please try again ",
//  context);
//  }
//  });
//  },
//  minWidth: 200.0,
//  height: 42.0,
//  child: Text(
//  'إنشاء حساب جديد',
//  style: TextStyle(
//  color: Colors.white,
//  fontSize: 17.0,
//  fontWeight: FontWeight.bold,
//  ),
//  ),
//  ),
//  ),

}
