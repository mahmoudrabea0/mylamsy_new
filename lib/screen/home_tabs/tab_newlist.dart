import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylamsy/controller/booking_meals_api.dart';
import 'package:mylamsy/screen/drawer_widget.dart';
import 'package:mylamsy/screen/home_tabs/tab_mylist.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
import '../main_screen.dart';

class TabNewList extends StatefulWidget {
  @override
  _TabNewListState createState() => _TabNewListState();
}

class _TabNewListState extends State<TabNewList> {
  BookingMeal bookingMeal = BookingMeal();
  TextEditingController titleController;
  TextEditingController contentController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _addSpicalMeal = GlobalKey<FormState>();

  int index;

  @override
  void initState() {
    titleController = TextEditingController();
    contentController = TextEditingController();
    index = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: CustomColors.GrayBack,
      appBar: sameAppBar(_scaffoldKey, context),
      drawer: sameDrawer(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: CustomColors.TypoGraphy,
        selectedItemColor: CustomColors.TypoGraphy,
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
      body: ListView(
        children: [
          Container(
            color: CustomColors.Primary,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  color: CustomColors.Primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TabMyList()),
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.meal_list.tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                FlatButton(
                  color: CustomColors.Primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TabNewList()),
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.add_new_special_meal.tr(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Form(
              key: _addSpicalMeal,
              child: Column(
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
                    height: 10,
                  ),
                  TextFormField(
                    controller: titleController,
                    autofocus: false,
                    validator: (val) {
                      if (val.isEmpty) {
                        return LocaleKeys.empty_field.tr();
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 12.0),
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
                    height: 10,
                  ),
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
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: contentController,
                    maxLines: 15,
                    autofocus: false,
                    validator: (val) {
                      if (val.isEmpty) {
                        return LocaleKeys.empty_field.tr();
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 12.0),
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
                      hintText: LocaleKeys.Write_notes.tr(),
                      hintStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Material(
                    color: CustomColors.Primary,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    elevation: 1.0,
                    child: MaterialButton(
                      onPressed: () async {
                        if (_addSpicalMeal.currentState.validate()) {
                          await bookingMeal
                              .setMealsToSpecial(
                                  titleController.text, contentController.text)
                              .then((onValue) {
                            if (onValue["id"] != null) {
                              titleController.clear();
                              contentController.clear();
                              final SnackBar mySnakBar = SnackBar(
                                  duration: const Duration(seconds: 3),
                                  content: Text(
                                    LocaleKeys.thank_you_meal.tr(),
                                    textAlign: TextAlign.center,
                                  ));
                              _scaffoldKey.currentState.showSnackBar(mySnakBar);
                            } else {
                              final SnackBar mySnakBar = SnackBar(
                                  duration: const Duration(seconds: 3),
                                  content: Text(
                                    LocaleKeys.sorry_no_order.tr(),
                                    textAlign: TextAlign.center,
                                  ));
                              _scaffoldKey.currentState.showSnackBar(mySnakBar);
                            }
                          });
                        }
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
            ),
          ),
        ],
      ),
    );
  }

  void onTappedBar(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen(index)),
    );
  }
}
