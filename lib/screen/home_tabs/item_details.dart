import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mylamsy/controller/booking_meals_api.dart';
import 'package:mylamsy/screen/drawer_widget.dart';
import 'package:mylamsy/screen/home_tabs/tab_mylist.dart';
import 'package:mylamsy/screen/home_tabs/tab_newlist.dart';
import 'package:mylamsy/screen/main_screen.dart';
import 'package:mylamsy/shared/commponent.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart'as http;

class ItemDetails extends StatefulWidget {
  Map map;

  ItemDetails(this.map);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}
String image;
class _ItemDetailsState extends State<ItemDetails> {
  final GlobalKey<ScaffoldState> detailsKey = new GlobalKey<ScaffoldState>();
  BookingMeal bookingMeal = BookingMeal();
  int index;

  var item_rate ;

 /* Future<String> createAlertDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    final _orderMeal = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'اضافة وصفة خاصة',
                  style: TextStyle(color: CustomColors.Primary),
                ),
              ],
            ),
            content: ListView(
              children: [
                Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'اسم الوجبة الخاصة',
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
                          hintText: 'عنوان الوجبة',
                          hintStyle: TextStyle(fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'طريقة الدفع',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'يتم الدفع عند الاستلام',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 13.0,
                          ),
                          child: Text(
                            'اضافة مكونات الوجبة',
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
                        maxLines: 10,
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
                        height: 25,
                      ),
                      Material(
                        color: CustomColors.Primary,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        elevation: 1.0,
                        child: MaterialButton(
                          onPressed: () async {

                           // if (_orderMeal.currentState.validate()) {
//                              await bookingMeal
//                                  .orderMeals(contentController.text)
//                                  .then((onValue) {
//                                if (onValue["id"] != null) {
//                                  SnackBar mySnakBar = SnackBar(
//                                      content: Text(
//                                    ' شكرا لك لطبيك واجبة من مطاعمنا.. وجبة لذيذة',
//                                    textAlign: TextAlign.center,
//                                  ));
//                                  detailsKey.currentState
//                                      .showSnackBar(mySnakBar);
//                                  Navigator.pop(context);
//                                } else {
//                                  final SnackBar mySnakBar = SnackBar(
//                                      duration: const Duration(seconds: 3),
//                                      content: Text(
//                                        'للاسف لم يتم الطلب تاكد من الاتصال لالانترنت و حاول مرة اخري',
//                                        textAlign: TextAlign.center,
//                                      ));
//                                  detailsKey.currentState
//                                      .showSnackBar(mySnakBar);
//                                }
//                              });
                            }
                         // }
                           ,
                          minWidth: double.infinity,
                          height: 37.0,
                          child: Text(
                            'اضافة الوصفة',
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
              ],
            ),
          );
        });
  }*/

  @override
  void initState() {
    index = 0;
    super.initState();

    try{item_rate = double.parse(widget.map["average_rating"]);}catch(e){
      item_rate = 3.5;
    }
    try{image =widget.map["images"][0]["src"];}catch(e){
      image = "https://via.placeholder.com/150";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: detailsKey,
      appBar: sameAppBar(detailsKey, context),
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
      body: SafeArea(
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
                      Navigator.pushReplacement(
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
            Column(
              children: <Widget>[
                Container(
                  height: 300,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 60,
                        right: 0,
                        left: 0,
                        child: Container(
                          child: ( image == null)
                              ? Image.asset(
                                  'images/food_seven.png',
                                )
                              : Image(
                                  loadingBuilder: (context, image,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) {
                                      return image;
                                    }
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
                                  image: NetworkImage(
                                    image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        top: 170,
                        left: 20,
                        right: 20,
                        bottom: 0,
                        child: Card(
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            widget.map["categories"][0]["name"],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: CustomColors.PrimaryHover),
                                        ),
                                        child: RaisedButton(
                                          elevation: 0,
                                          onPressed: () {
                                            createAlertDialog(context,widget.map,detailsKey);
                                          },
                                          color: Colors.white,
                                          child: Text(
                                            LocaleKeys.order_now.tr(),
                                            style: TextStyle(
                                                color: CustomColors.Primary),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Align(
                                          alignment: Alignment.topCenter,
                                          child: SmoothStarRating(
                                              allowHalfRating: false,
                                              starCount: 5,
                                              rating: item_rate,
                                              size: 20.0,
                                              isReadOnly: true,
                                              defaultIconData: Icons.star_border,
                                              filledIconData: Icons.star,
                                              color: CustomColors.Warning,
                                              borderColor: Colors.grey,
                                              spacing: 0.0)
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            widget.map["name"],
                                            style: TextStyle(
                                                fontSize: 18,
                                                color:
                                                    CustomColors.SecondaryHover,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              LocaleKeys.price_meal.tr(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            ),
                                            Text("  "),
                                            Text(
                                              widget.map["price"]+"\$",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: CustomColors.Primary),
                                            ),

                                          ],
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                    removeAllHtmlTags(widget.map["description"]),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black)
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 100,
                  width: double.infinity,
                  color: CustomColors.GrayBack,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(LocaleKeys.rate_meal.tr(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700)),
                      GestureDetector(
                        onTap: (){
                          _onAlertWithCustomContentPressed(context,widget.map["id"]);
                        },
                        child: SmoothStarRating(
                            allowHalfRating: false,
                            starCount: 5,
                            rating: 0,
                            size: 30.0,
                            isReadOnly: true,
                            defaultIconData: Icons.star_border,
                            filledIconData: Icons.star,
                            color: CustomColors.Warning,
                            borderColor: Colors.grey,
                            spacing: 0.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
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
  _onAlertWithCustomContentPressed(context,id) {
    double _rate;
    Alert(
        context: context,
        title: "RATE",
        content: Column(
          children: <Widget>[
            SmoothStarRating(
                allowHalfRating: true,
                onRated: (rate){
                  _rate = rate;
                },

                starCount: 5,
                rating: 0,
                size: 30.0,
                isReadOnly: false,
                defaultIconData: Icons.star_border,
                filledIconData: Icons.star,
                color: CustomColors.Warning,
                borderColor: Colors.grey,
                spacing: 0.0)
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
              rateProduct(id,_rate);
              } ,
            child: Text(
              "Rate",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
  Future rateProduct(int productId,double rate) async {
    final auth = 'Basic ' +
        base64Encode(utf8.encode(
            'mostapha94:6060660'));
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id");
    final response = await http.post(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wp/v2/add_rating_to_product"),
        body: jsonEncode({
          'product_id':productId,
          'user_id':id,
          'review': "review",
          "rating": rate
        }),
        headers: {'content-type': 'application/json',
          'accept': 'application/json',"authorization": auth});
    print(response.body);
    if (response.statusCode == 200) {
      var jason = jsonDecode(response.body);
      return jason;
    }
    return null;
  }
}

