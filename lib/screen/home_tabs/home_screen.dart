import 'dart:core';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylamsy/controller/booking_doctor_api.dart';
import 'package:mylamsy/main.dart';
import 'package:mylamsy/screen/appbar/notification_screen.dart';
import 'package:mylamsy/screen/home_tabs/item_details.dart';
import 'package:mylamsy/screen/home_tabs/search_bar_Screen.dart';
import 'package:mylamsy/screen/home_tabs/tab_mylist.dart';
import 'package:mylamsy/screen/home_tabs/tab_newlist.dart';
import 'package:mylamsy/style/SimilarWidgets.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:mylamsy/shared/commponent.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
import 'package:mylamsy/utilities/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
SharedPreferences preferences;
List<String> newlist = [];
String new_id;
String category;
List<String> oldlist = [];
class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver{
  @override
  void initState(){
    super.initState();
    bookingDoctor = BookingDoctor();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        navigateTo(context, NotificationScreen());
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      preferences = await SharedPreferences.getInstance();
      if (notification != null && android != null) {
        print(message.data.toString());
        // final jsonBody = jsonDecode(event.data.toString()) as List;
        //final Map dat= jsonDecode(event.data.toString());
        // print("kk"+jsonBody.toString());

        showToast(text:message.notification.body);
        new_id = message.data['product_id'];
        print(new_id);
        oldlist = preferences.getStringList('product_id');
        print("Test"+oldlist.toString());
        if(oldlist == null){
          newlist.add(new_id);
        }else{
          newlist=oldlist;
          newlist.add(new_id);
        }
        print(newlist.toString());
        preferences.setStringList('product_id', newlist);
        print(" Ok ${preferences.getStringList('product_id')}");
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launcher_icon',
              ),
            ));
      }

    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print(message.data.toString());
      // final jsonBody = jsonDecode(event.data.toString()) as List;
      //final Map dat= jsonDecode(event.data.toString());
      // print("kk"+jsonBody.toString());

      showToast(text:message.notification.body);
      new_id = message.data['product_id'];
      print(new_id);
      oldlist = preferences.getStringList('product_id');
      print("Test"+oldlist.toString());
      if(oldlist == null){
        newlist.add(new_id);
      }else{
        newlist=oldlist;
        newlist.add(new_id);
      }
      print(newlist.toString());
      preferences.setStringList('product_id', newlist);
      print(" Ok ${preferences.getStringList('product_id')}");
      navigateTo(context, NotificationScreen());
    });
  }

 /* @override
  void dispose() {
      Timer(Duration(seconds: 20),getNotif());
      WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }*/
  /*@override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.paused:
        Timer(Duration(seconds: 20),getNotif());
        break;
      case AppLifecycleState.resumed:
        Timer(Duration(seconds: 20),getNotif());
        break;
      case AppLifecycleState.inactive:
        Timer(Duration(seconds: 20),getNotif());
        break;
      case AppLifecycleState.detached:
        Timer(Duration(seconds: 20),getNotif());
        break;
    }
  }*/
  BookingDoctor bookingDoctor;

  TextEditingController sreachController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var locale =context.locale;
   // notificationonMessageOpenedApp(context);
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: CustomColors.GrayBack,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.Primary,
          actions: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: sreachController,
                autofocus: false,
                onChanged: (value) {
                  showSearch(
                      context: context,
                      delegate: SearchBarScreen(),
                      query: sreachController.text);
                },
                cursorColor: Colors.black,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: LocaleKeys.search.tr(),
                  prefixIcon: Icon(
                    Icons.search,
                    color: CustomColors.Primary,
                    size: 30,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.zero,
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
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  LocaleKeys.meals_from_ketch.tr(),
                  style: TextStyle(
                      fontSize: 25,
                      color: CustomColors.Primary,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            FutureBuilder(
              future: bookingDoctor.getMeals(locale),
              builder: (context, snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return emptyPage(context);
                    break;
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.green,
                        ));
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, pos) {
                            return mealContainer(context,snapshot.data[pos]);
                          });
                    }
                    return emptyPage(context);
                    break;
                }
                return emptyPage(context);
              },
            )
          ],
        ));
  }

  Widget mealContainer(
    BuildContext context,
      product
  ) {
    String image;
    try{image =product['images'][0]['src'];}catch(e){
      image = "https://via.placeholder.com/150";
    }


    return GestureDetector(
      onTap: () {
         Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemDetails(product)),

          );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                child: Container(
                  width: 100,
                  height: double.infinity,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            product['name'],
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 18,
                              color: CustomColors.SecondaryHover,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              LocaleKeys.price_meal.tr(),
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                            Text("  "),
                            Text(
                              product['price']+"\$",
                              style: TextStyle(
                                  fontSize: 16, color: CustomColors.Primary),
                              textAlign: TextAlign.right,
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[
                      Text(product["categories"][0]["name"],style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black)
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: CustomColors.PrimaryHover),
                        ),
                        child: RaisedButton(
                          elevation: 0,
                          onPressed: () {
                            createAlertDialog(context,product,_scaffoldKey);
                          },
                          color: Colors.white,
                          child: Text(
                            LocaleKeys.order_now.tr(),
                            style: TextStyle(color: CustomColors.Primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }


}
/*
getNotif() async {
  showToast(text:"test test");
  showNotification("1");
  SharedPreferences preferences = await SharedPreferences.getInstance();
  showNotification("2");
  final auth ='Basic ' + base64Encode(utf8.encode('mostapha94:6060660'));
  showNotification("3");
  var response = await http.get(
      Uri.parse("https://demo.mahacode.com/mylamsy/wp-json/wc/v3/products?category=20,21,15"),
      headers: {"Accept": "application/json","authorization": auth});
  showNotification("4");
  print(response.body);
  showNotification("5");
  if (response.statusCode == 200) {
    showNotification("6");
    var jason = jsonDecode(response.body);
    showNotification("7");
    print(jason.length.toString());
    showNotification("8");
    if (preferences.getInt("length")!=jason.length){

      showNotification("9");
      //_streamController.add(jason);
    }
    showNotification("10");
    print("yes");
    await preferences.setInt("length",jason.length );

  }else{
    print("NO");
    showNotification("11");
  }


}*/
