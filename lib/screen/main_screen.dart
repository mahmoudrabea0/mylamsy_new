import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylamsy/screen/appbar/notification_screen.dart';
import 'package:mylamsy/screen/appbar/profile/profile_screen.dart';
import 'package:mylamsy/screen/doctor/doctor_screen.dart';
import 'package:mylamsy/screen/home_tabs/home_screen.dart';
import 'package:mylamsy/screen/program/program_screen.dart';
import 'package:mylamsy/shared/commponent.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import '../translations/locale_keys.g.dart';
import 'drawer_widget.dart';

class MainScreen extends StatefulWidget {
  int currentIndex;

  MainScreen(this.currentIndex);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver{
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                Text(
                  LocaleKeys.add_new_special_meal.tr(),
                  style: TextStyle(color: CustomColors.Primary),
                ),
              ],
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    LocaleKeys.name_special_meals.tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                TextField(
                  autofocus: false,
                  onChanged: (value) {},
                  cursorColor: Colors.black,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
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
                    hintText: LocaleKeys.adrress_meal.tr(),
                    hintStyle: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    LocaleKeys.chose_kind.tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                TextField(
                  autofocus: false,
                  onChanged: (value) {},
                  cursorColor: Colors.black,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 25,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
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
                    hintText: LocaleKeys.breakfast.tr(),
                    hintStyle: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 13),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      LocaleKeys.Choose_shipping_address.tr(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                TextField(
                  autofocus: false,
                  onChanged: (value) {},
                  cursorColor: Colors.black,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 25,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
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
                    hintText: LocaleKeys.home_address.tr(),
                    hintStyle: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    LocaleKeys.Meal_delivery.tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 110,
                      child: TextField(
                        autofocus: false,
                        onChanged: (value) {},
                        cursorColor: Colors.black,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 25,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
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
                          hintText: LocaleKeys.Tuesday.tr(),
                          hintStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 110,
                      child: TextField(
                        autofocus: false,
                        onChanged: (value) {},
                        cursorColor: Colors.black,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 25,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
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
                          hintText: LocaleKeys.Saturday.tr(),
                          hintStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    LocaleKeys.Meal_time.tr(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  autofocus: false,
                  onChanged: (value) {},
                  cursorColor: Colors.black,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
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
                    hintText: '2:30 PM',
                    hintStyle: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.add,
                          color: CustomColors.Primary,
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 13.0,
                        ),
                        child: Text(
                          LocaleKeys.Add_meal.tr(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 13.0,
                    ),
                    child: Text(
                      LocaleKeys.Write_notes.tr(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Material(
                  color: CustomColors.Primary,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  elevation: 1.0,
                  child: MaterialButton(
                    onPressed: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginValidation(),),);
                    },
                    minWidth: double.infinity,
                    height: 37.0,
                    child: Text(
                      LocaleKeys.add_recipe.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  int _currentIndex;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _currentIndex = widget.currentIndex;

    super.initState();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
   switch(state){
     case AppLifecycleState.paused:
       //showToast(text: "paused");
       break;
     case AppLifecycleState.inactive:
       //showToast(text: "inactive");
       break;
     case AppLifecycleState.resumed:

       break;
     case AppLifecycleState.detached:
       int i = 1;
       Timer.periodic(Duration(seconds: 2), (timer) {
        // showToast(text: "Toast $i");
         i++;
       });
       break;
   }

  }
  final List<Widget> _children = [
    DoctorScreen(),
    ProgramScreen(),
    HomeScreen(),
  ];
  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      // app Bar
      appBar: sameAppBar(scaffoldKey, context),
      body: _children[_currentIndex],

      // bottom navigator bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),
            title: Text(
              LocaleKeys.doctor_consult.tr(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text(
              LocaleKeys.programs.tr(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              LocaleKeys.main_dishes.tr(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon: Icon(Icons.home),
          ),
        ],
        onTap: onTappedBar,
      ),

      // drawer menu bar
      drawer: sameDrawer(context),
    );
  }

  Widget _imageAppBar(String image, Function onPressed, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: IconButton(
          icon: Image.asset(
            image,
            color: Colors.white,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
