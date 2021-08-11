import 'package:flutter/material.dart';
import 'package:mylamsy/screen/all_auth_screens/login_screen.dart';
import 'package:mylamsy/screen/conact_us.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
import 'package:mylamsy/utilities/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'about_us.dart';
import 'appbar/notification_screen.dart';
import 'appbar/order/order_screen.dart';
import 'appbar/profile/profile_screen.dart';
import 'main_screen.dart';
int _value = 2;
Widget sameDrawer(BuildContext context){
  return Drawer(
    child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: CustomColors.SecondaryHover,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: CustomColors.SecondaryHover,
            ),
            // header Drawer
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Avatar image
                CircleAvatar(
                  backgroundImage: AssetImage(
                    'images/logo.png',
                  ),
                  radius: 45,
                  backgroundColor: Colors.white,
                ),
                // user name
              ],
            ),
          ),
          // item Menu Bar Drawer
          Padding(
            padding: EdgeInsetsDirectional.only(start: 10),
            child: Container(

              height: MediaQuery.of(context).size.height,
              //width: MediaQuery.of(context).size.width,
              color: CustomColors.SecondaryHover,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(2),
                          ),
                        );
                      },
                      child: _itemMenuBar(
                        LocaleKeys.main_dishes.tr(),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.black26,
                    thickness: 0.5,
                    endIndent: 0,
                    indent: 0,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(1),
                          ),
                        );
                      },
                      child: _itemMenuBar(
                        LocaleKeys.programs.tr(),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.black26,
                    thickness: 0.5,
                    endIndent: 0,
                    indent: 0,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(0),
                          ),
                        );
                      },
                      child: _itemMenuBar(
                        LocaleKeys.doctor_list.tr(),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.black26,
                    thickness: 0.5,
                    endIndent: 0,
                    indent: 0,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
                      child: _itemMenuBar(
                        LocaleKeys.account_settings.tr()
                        ,
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.black26,
                    thickness: 0.5,
                    endIndent: 0,
                    indent: 0,
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.black26,
                    thickness: 0.5,
                    endIndent: 0,
                    indent: 0,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactUS(),
                          ),
                        );
                      },
                      child: _itemMenuBar(
                  LocaleKeys.contact_us.tr() ,
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.black26,
                    thickness: 0.5,
                    endIndent: 0,
                    indent: 0,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => AboutUs()));
                      },
                      child: _itemMenuBar(
                          LocaleKeys.about.tr() ,
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.black26,
                    thickness: 0.5,
                    endIndent: 0,
                    indent: 0,
                  ),
                  Container(
                    child: InkWell(
                      onTap: () {
                        SharedPreferences.getInstance().then((value) {
                          SharedPreferences pref = value;
                          pref.setString("id", null);
                        });
                        navigateAndFinish(context, LoginScreen());
                       /* Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                                */
                      },
                      child: _itemMenuBar(
                          LocaleKeys.logout.tr() ,
                      ),
                    ),
                  ),
                  ListTile(
                      visualDensity:
                      VisualDensity(horizontal: -4, vertical: -4),
                      leading: Icon(Icons.language,color: Colors.white,),
                      title: DropdownButton(
                        dropdownColor: Colors.deepOrange,
                          value: _value,
                          icon: Text(" "),
                          underline: Text(" "),
                          items: [
                            DropdownMenuItem(
                              child: Text("اللغه العربيه",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18)),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("English",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18)),
                              value: 2,
                            ),
                          ],
                          onChanged: (value) {
                              _value = value;
                              if(value == 1){
                                context.locale=Locale('ar');
                              }else{
                                context.locale=Locale('en');
                              }
                          }),
                      onTap: () {

                      })
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _itemMenuBar(String title) {
  return ListTile(
    title: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    ),
  );
}

Widget sameAppBar(GlobalKey<ScaffoldState> scaffoldKey, BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,

    // menu icon
    leading: Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: CustomColors.Light,
        ),
        child: IconButton(
          icon: Image.asset(
            "images/list_icon.png",
            color: CustomColors.TypoGraphy,
          ),
          iconSize: 30,
          onPressed: () {
            scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
    ),

    actions: <Widget>[
      _imageAppBar("images/notif_icon.png", () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationScreen(),
          ),
        );
      }, CustomColors.ReverseDark,false),
      _imageAppBar("images/icon.png", () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderScreen()));
      }, CustomColors.PrimaryHover,false),
      _imageAppBar("images/person_icon.png", () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(),
          ),
        );
      }, CustomColors.Secondary,false),
    ],
  );
}

Widget _imageAppBar(String image, Function onPressed, Color color,bool notification) {
  return Stack(
    children: [
      Padding(
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
      ),
    ],
  );
}
