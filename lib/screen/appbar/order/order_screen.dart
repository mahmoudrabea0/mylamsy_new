import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylamsy/controller/booking_meals_api.dart';
import 'package:mylamsy/controller/order_api.dart';
import 'package:mylamsy/screen/drawer_widget.dart';
import 'package:mylamsy/screen/home_tabs/item_details.dart';
import 'package:mylamsy/screen/home_tabs/tab_newlist.dart';
import 'package:mylamsy/style/SimilarWidgets.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:mylamsy/shared/commponent.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  AllOrdersApi allOrdersApi = AllOrdersApi();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: sameAppBar(_scaffoldKey, context),
      drawer: sameDrawer(context),
      backgroundColor: CustomColors.GrayBack,
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => OrderScreen()),
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
          Container(
            padding: EdgeInsets.all(4),
            width: MediaQuery.of(context).size.width,
            color: CustomColors.Reverse,
            child: Text(
              'طلباتى',
              style: TextStyle(
                  fontSize: 25,
                  color: CustomColors.Secondary,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          FutureBuilder(
            future: allOrdersApi.getordersOfSinglecustomer(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                    print(snapshot.data.length.toString()+"yyiyg");
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, pos) {
                          return itemContainer(context, snapshot.data[pos]);
                        });
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

  Widget itemContainer(BuildContext context,  map) {
    print("kkuy"+map.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            /* Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                map["categories"][0]["name"],
                style: TextStyle(
                    fontSize: 30,
                    color: CustomColors.Primary,
                    fontWeight: FontWeight.bold),
              )),
            ),*/
            mealContainer(context,map)
          ],
        ),
      ),
    );
  }

  Widget mealContainer(BuildContext context, Map data) {
    try{image =data["images"][0]["src"];}catch(e){
      image = "https://via.placeholder.com/150";
    }
    print(data.toString());
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemDetails(data)),
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height * .125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(3.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 90,
                            child: Text(
                              data["categories"][0]["name"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: CustomColors.PrimaryHover),
                        ),
                        child: RaisedButton(
                          elevation: 0,
                          onPressed: () {
                            createAlertDialog(context,data,_scaffoldKey);
                          },
                          color: Colors.white,
                          child: Text(
                            'اطلب الان',
                            style: TextStyle(color: CustomColors.Primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          data["name"],
                          style: TextStyle(
                              fontSize: 18,
                              color: CustomColors.SecondaryHover,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              data["price"],
                              style: TextStyle(
                                  fontSize: 16, color: CustomColors.Primary),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              '  سعر الوجبه',
                              style:
                              TextStyle(fontSize: 16, color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.22,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(9),
                      bottomLeft: Radius.circular(9),
                    ),
                    child: Container(
                      child: (image == null)
                          ? Image.asset(
                        "assets/images/logo.png",
                      )
                          : Image(
                        loadingBuilder: (context, image,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) {
                            return image;
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        image: NetworkImage(
                          image,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*createAlertDialog(BuildContext context,orderdata) {
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
                        print("clicked");
                        if (_orderMeal.currentState.validate()) {
                          await bookingMeal.orderMeals(
                              orderdata,
                              typeMealController,
                              addressController,
                              firstDate ,
                              lastDate ,
                              timeController ,
                              commentController
                          ).then((onValue) {
                                print(onValue.toString());
                            if (onValue["id"] != null) {
                              print(onValue.toString());
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
                            print(e.toString());
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
  }*/
}
