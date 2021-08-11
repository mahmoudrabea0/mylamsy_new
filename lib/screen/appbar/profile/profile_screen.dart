import 'package:flutter/material.dart';
import 'package:mylamsy/controller/auth_Api.dart';
import 'package:mylamsy/screen/home_tabs/tab_mylist.dart';
import 'package:mylamsy/screen/home_tabs/tab_newlist.dart';
import 'package:mylamsy/style/SimilarWidgets.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
import '../../drawer_widget.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> profileKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Authentication auth = Authentication();
    return Scaffold(
      backgroundColor: Colors.white,
      key: profileKey,
      appBar: sameAppBar(profileKey, context),
      drawer: sameDrawer(context),
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
          FutureBuilder(
            future: auth.getAnUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return emptyPage(context);
                  break;
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    ),
                  );
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return drawUserDetails(snapshot);
                  }
                  return emptyPage(context);
                  break;
              }
              return emptyPage(context);
            },
          ),
        ],
      ),
    );
  }

  Widget drawUserDetails(AsyncSnapshot snapshot) {
    Map data = snapshot.data;
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .37,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                bottom: 200,
                right: 0,
                left: 0,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'images/banner.png',
                        ),
                        fit: BoxFit.fitWidth),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 25,
                right: 10,
                left: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColors.Primary,
                        image: DecorationImage(
                            image: (data["meta"]["user_photo"] == null ||
                                    data["meta"]["user_photo"] == "")
                                ? ExactAssetImage(
                                    "assets/images/logo.png",
                                  )
                                : NetworkImage(
                                    data["meta"]["user_photo"],
                                  ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          data['name'],
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.Primary),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10, left: 10, top: 10),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          data["description"],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Divider(
                  height: 5.0,
                  color: Colors.grey,
                  thickness: 1.0,
                  endIndent: 2,
                  indent: 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          //todo:email is not complete
                          data["user_email"],
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                           fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: CustomColors.Secondary,
                          ),
                        ),
                        Text(
                          LocaleKeys.eamil.tr(),
                          textAlign: TextAlign.end,

                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 5.0,
                  color: Colors.grey,
                  thickness: 1.0,
                  endIndent: 2,
                  indent: 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        data["meta"]["city"],
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CustomColors.Secondary,
                            fontSize: 18),
                      ),
                      Text(
                        LocaleKeys.residence.tr(),
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 5.0,
                  color: Colors.grey,
                  thickness: 1.0,
                  endIndent: 2,
                  indent: 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        data["meta"]["address"],
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CustomColors.Secondary,
                            fontSize: 18),
                      ),
                      Text(
                        LocaleKeys.ship_address.tr(),
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 5.0,
                  color: Colors.grey,
                  thickness: 1.0,
                  endIndent: 2,
                  indent: 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        data["meta"]["phone_number"],
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: CustomColors.Secondary,
                            fontSize: 18),
                      ),
                      Text(
                        LocaleKeys.phone.tr(),
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 5.0,
                  color: Colors.grey,
                  thickness: 1.0,
                  endIndent: 2,
                  indent: 2,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        MaterialButton(
          height: 60,
          minWidth: double.infinity,
          color: Colors.black,
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfileScreen(data)));
          },
          child: Align(
            alignment: Alignment.center,
            child: Text(
              LocaleKeys.edit_user_info.tr(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
