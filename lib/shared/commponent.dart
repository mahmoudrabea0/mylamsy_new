import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mylamsy/controller/booking_meals_api.dart';
import 'package:mylamsy/screen/appbar/notification_screen.dart';
import 'package:mylamsy/screen/home_tabs/tab_mylist.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:mylamsy/utilities/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
BookingMeal bookingMeal = BookingMeal();
createAlertDialog( context,orderdata,_scaffoldKey) {
  TextEditingController typeMealController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController firstDate = TextEditingController();
  TextEditingController lastDate = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  final _orderMeal = GlobalKey<FormState>();
  return showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'اضافة الوجبة',
                style: TextStyle(color: CustomColors.Primary),
              ),
            ],
          ),
          content: Form(
            key: _orderMeal,
            child: ListView(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'اختيار نوع الوجبة',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: typeMealController,
                  autofocus: false,
                  onChanged: (value) {},
                  cursorColor: Colors.black,
                  textAlign: TextAlign.right,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "يجب عليك استكمال هذا الحقل ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
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
                    hintText: 'افطار',
                    hintStyle: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 13),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'اختيار عنوان الشحن',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: TextFormField(
                    controller: addressController,
                    autofocus: false,
                    onChanged: (value) {},
                    validator: (val) {
                      if (val.isEmpty) {
                        return "يجب عليك استكمال هذا الحقل ";
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
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
                      hintText: 'عنوان البيت',
                      hintStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'ايام توصيل الوجبة',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 110,
                      child: TextFormField(
                        controller: firstDate,
                        autofocus: false,
                        onChanged: (value) {},
                        validator: (val) {
                          if (val.isEmpty) {
                            return "يجب عليك استكمال هذا الحقل ";
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
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
                          hintText: 'الثلاثاء',
                          hintStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 110,
                      child: TextFormField(
                        controller: lastDate,
                        autofocus: false,
                        onChanged: (value) {},
                        validator: (val) {
                          if (val.isEmpty) {
                            return "يجب عليك استكمال هذا الحقل ";
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
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
                          hintText: 'السبت',
                          hintStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'موعد توصيل الوجبة',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: timeController,
                  autofocus: false,
                  onChanged: (value) {},
                  validator: (val) {
                    if (val.isEmpty) {
                      return "يجب عليك استكمال هذا الحقل ";
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
                    hintText: '2:30 PM',
                    hintStyle: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'ملاحظات خاصة',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: commentController,
                  maxLines: 5,
                  autofocus: false,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "يجب عليك استكمال هذا الحقل ";
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
                    hintText: 'اكتب ملاحظات عن الوجبة',
                    hintStyle: TextStyle(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Material(
                  color: CustomColors.Primary,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  elevation: 1.0,
                  child: MaterialButton(
                    onPressed: () async {
                      if (_orderMeal.currentState.validate()) {
                        await bookingMeal.orderMeals(
                            orderdata,
                            typeMealController.text,
                            addressController.text,
                            firstDate.text ,
                            lastDate.text ,
                            timeController.text ,
                            commentController.text
                        ).then((onValue) {
                          print(onValue.toString());
                          if (onValue["id"] != null) {
                            print('kf'+onValue.toString());
                            SnackBar mySnakBar = SnackBar(
                                content: Text(
                                  ' شكرا لك لطبيك واجبة من مطاعمنا.. وجبة لذيذة',
                                  textAlign: TextAlign.center,
                                ));
                            _scaffoldKey.currentState.showSnackBar(mySnakBar);
                            Navigator.pop(context);
                          } else {
                            final SnackBar mySnakBar = SnackBar(
                                duration: const Duration(seconds: 3),
                                content: Text(
                                  'للاسف لم يتم الطلب تاكد من الاتصال لالانترنت و حاول مرة اخري',
                                  textAlign: TextAlign.center,
                                ));
                            _scaffoldKey.currentState.showSnackBar(mySnakBar);
                          }
                        }).catchError((e){
                          print('jhjghj'+e.toString());
                        });
                      }
                    },
                    minWidth: double.infinity,
                    height: 37.0,
                    child: Text(
                      'اضافة الوجبة',
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
        );
      });
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: false,
      caseSensitive: true
  );
  String m =htmlText.replaceAll('&nbsp;','');
  return m.replaceAll(exp, '');
}
void showToast({
  @required text,

}) =>
    Fluttertoast.showToast(
      msg: text.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.blue ,
      textColor: Colors.white,
      fontSize: 16.0,
    );

/*notificationonMessageOpenedApp(context) async{
  preferences = await SharedPreferences.getInstance();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
   // final jsonBody = jsonDecode(event.data.toString()) as List;
    //final Map dat= jsonDecode(event.data.toString());
   // print("kk"+jsonBody.toString());

    showToast(text:event.notification.body);
    new_id = event.data['product_id'];
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
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    showToast(text:event.notification.body);
    new_id = event.data["product_id"];
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
  FirebaseMessaging.onBackgroundMessage((message) {
    showToast(text:message.notification.body+"khhc");
     new_id = message.data["product_id"];
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
     return ;
  });
}*/


/*void callbackDispatcher(title,body) {

  // initial notifications
  var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings();

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  WidgetsFlutterBinding.ensureInitialized();

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
    showNotification(title,body);
}
Future showNotification(title,body) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    '1.0',
    'Mylamsy',
    'For Healthy food',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,

  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails(
    threadIdentifier: 'thread_id',
  );
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics
  );

  await flutterLocalNotificationsPlugin.show(
    1,
    title,
    body,
    platformChannelSpecifics,
  );

  /// periodically...but const id && const title,body
  *//*await flutterLocalNotificationsPlugin.periodicallyShow(
    Random().nextInt(azkar.length-1),
    'السلام عليكم',
    azkar[Random().nextInt(azkar.length-1)],
    RepeatInterval.everyMinute,
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    payload: '',
  );*//*

}*/
