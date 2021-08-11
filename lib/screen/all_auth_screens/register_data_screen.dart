import 'package:flutter/material.dart';
import 'package:mylamsy/controller/auth_Api.dart';
import 'package:mylamsy/screen/main_screen.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:mylamsy/utilities/preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
class RegisterDataScreen extends StatefulWidget {
  @override
  _RegisterDataScreenState createState() => _RegisterDataScreenState();
}

class _RegisterDataScreenState extends State<RegisterDataScreen> {
  final _completeDataKey = GlobalKey<FormState>();
  Authentication auth;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _countryController;
  TextEditingController _cityController;
  TextEditingController _addressController;
  TextEditingController _phoneController;
  TextEditingController _descriptionController;

  void initState() {
    auth = Authentication();
    _countryController = TextEditingController();
    _cityController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _completeDataKey,
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/login_cover.png'),
                    fit: BoxFit.cover),
              ),
              child: Column(
                children: <Widget>[
                  // bannar text
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          CustomColors.Secondary,
                          CustomColors.Primary,
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(100, 100),
                        bottomRight: Radius.elliptical(100, 100),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        LocaleKeys.complete_info.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),

                        // country
                        _normalTextField(LocaleKeys.country.tr(), 1, _countryController),
                        SizedBox(
                          height: 20.0,
                        ),

                        // city
                        _normalTextField(LocaleKeys.city.tr(), 1, _cityController),
                        SizedBox(
                          height: 20.0,
                        ),

                        // order address
                        _normalTextField(LocaleKeys.ship_address.tr(), 1, _addressController),
                        SizedBox(
                          height: 20.0,
                        ),

                        // phone number
                        _normalTextField(LocaleKeys.phone.tr(), 1, _phoneController),
                        SizedBox(
                          height: 20.0,
                        ),

                        // custom TextField
                        _normalTextField(
                            LocaleKeys.about_you.tr(), 7, _descriptionController),
                        SizedBox(
                          height: 20.0,
                        ),

                        // Material Button
                        Material(
                          color: CustomColors.Primary,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          elevation: 1.0,
                          child: MaterialButton(
                            onPressed: () {
                             /* Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(2),
                                ),
                              );*/
                              if (_completeDataKey.currentState.validate()) {
                                auth.completeUserData(
                                  _countryController.text,
                                  _cityController.text,
                                  _addressController.text,
                                  _phoneController.text,
                                  _descriptionController.text,
                                )
                                    .then((onValue) {
                                      print("ينبتنيبى"+onValue.toString());
                                  if (onValue == 'done') {
                                    navigateAndFinish(context, MainScreen(2));
                                    /*final SnackBar mySnakBar = SnackBar(
                                        duration: const Duration(seconds: 3),
                                        content: Text(
                                          "تم تحديث البيانات شكرا لك",
                                          textAlign: TextAlign.center,
                                        ));
                                    _scaffoldKey.currentState
                                        .showSnackBar(mySnakBar);
                                    setState(() {
                                      _countryController.clear();
                                      _descriptionController.clear();
                                      _phoneController.clear();
                                      _cityController.clear();
                                      _addressController.clear();
                                    });*/
                                 } else {
                                    print("not done");
                                   /*final SnackBar mySnakBar = SnackBar(
                                       duration: const Duration(seconds: 3),
                                       content: Text(
                                         "نعتذر لم يكتمل التحديث",
                                          textAlign: TextAlign.center,
                                       ));
                                   _scaffoldKey.currentState
                                      .showSnackBar(mySnakBar);*/
                                 }
                               });
                              }
                            },
                            minWidth: 200.0,
                            height: 42.0,
                            child: Text(
                              LocaleKeys.start.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _normalTextField(
      String title, int lines, TextEditingController controll) {
    return TextFormField(
      controller: controll,
      autofocus: false,
      maxLines: lines,
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
}
