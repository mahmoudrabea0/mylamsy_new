import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mylamsy/main.dart';
import 'package:mylamsy/screen/appbar/notification_service.dart';
import 'package:mylamsy/screen/doctor/doctor_profile.dart';
import 'package:mylamsy/screen/home_tabs/item_details.dart';
import 'package:mylamsy/screen/home_tabs/tab_mylist.dart';
import 'package:mylamsy/screen/home_tabs/tab_newlist.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../drawer_widget.dart';
import '../main_screen.dart';
import 'package:easy_localization/easy_localization.dart';
class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}
StreamController _streamController;
class _NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int index;

  @override
  void initState() {
    index = 0;
    super.initState();
    _streamController = new StreamController();
    loadPosts();
   // getNoti();
  }

  @override
  Widget build(BuildContext context) {
    print("انا ها");
    var locale=context.locale;
    return Scaffold(
      backgroundColor: CustomColors.GrayBack,
      key: scaffoldKey,
      appBar: sameAppBar(scaffoldKey, context),
      drawer: sameDrawer(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: CustomColors.TypoGraphy,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: CustomColors.TypoGraphy,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.healing),
            title: Text(
              'إستشارة طبيب',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text(
              'البرامج التفاعلية',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              'الاطباق الرئيسية',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon: Icon(Icons.home),
          ),
        ],
        onTap: onTappedBar,
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
          children: <Widget>[
            Container(
              color: CustomColors.Primary,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    color: CustomColors.Primary,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => TabMyList()),
                      );
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'قائمة وصفاتي',
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => TabNewList()),
                      );
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'إضافة وصفة خاصة',
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
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'قائمة التنبيهات',
                    style: TextStyle(
                        fontSize: 30,
                        color: CustomColors.Primary,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: StreamBuilder(
                stream:_streamController.stream,
                builder:(BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                     return  ListView.builder(
                         shrinkWrap: true,
                         physics: BouncingScrollPhysics(),
                         itemCount: snapshot.data.length,
                         itemBuilder: (context, pos) {
                           return getContainer(snapshot.data[pos],context);
                         });
                  }else if(snapshot.hasError){
                    print(snapshot.error.toString()+"jk");
                   return  Container(child: Center(child: Text("لايوجد تنبيهات حتى الان")),);
                  }
                 return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            /*Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'اجعل الكل مقروء',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  )),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget getContainer(product,context) {

    return GestureDetector(
      onTap: (){
        if(product['categories'][0]['id']==24){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DoctorProfile(product)),
          );
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemDetails(product)),
          );
        }

      },
      child: Container(
        height: 80,
        margin: EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                )),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      product['name'].toString(),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product['images'][0]['src']),
                  fit: BoxFit.cover,
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
      title: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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

  void onTappedBar(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen(index)),
    );
  }
}

Future  getNoti() async {
  //SharedPreferences preferences = await SharedPreferences.getInstance();
  final auth ='Basic ' + base64Encode(utf8.encode('mostapha94:6060660'));
  final List<String> notifstring = await preferences.getStringList('product_id');
 // final List<String> products_id=[];
  String d = notifstring.toString().replaceAll(']', "").replaceAll('[', "");
  print("llp"+d);
  var response = await http.get(
      Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wc/v2/products/?include=$d"),
      headers: {"Accept": "application/json","authorization": auth});
  print("oooo"+response.body);
  if (response.statusCode == 200) {
    var jason = jsonDecode(response.body);

    print("oooo"+jason.length.toString());

   /* if (preferences.getInt("length")!=jason.length){
      //_streamController.add(jason);
    }*/
  //  print("yes");
   // await preferences.setInt("length",jason.length );
    return jason;

  }else{
    print("NO");
  }


}
loadPosts() async {
  getNoti().then((res) async {
    _streamController.add(res);
    return res;
  });
}
Future<Null> _handleRefresh() async {
  getNoti().then((res) async {
    _streamController.add(res);
    return null;
  });
}