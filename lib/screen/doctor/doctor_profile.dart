import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylamsy/controller/booking_doctor_api.dart';
import 'package:mylamsy/screen/home_tabs/tab_mylist.dart';
import 'package:mylamsy/screen/home_tabs/tab_newlist.dart';
import 'package:mylamsy/shared/commponent.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
import '../drawer_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
  Map<String, dynamic> singleDoctor;

  DoctorProfile(this.singleDoctor);
}

class _DoctorProfileState extends State<DoctorProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  BookingDoctor bookingDoctor = BookingDoctor();

  @override
  Widget build(BuildContext context) {
    String image;
    try{image =widget.singleDoctor['images'][0]['src'];}catch(e){
      image = "https://via.placeholder.com/150";
    }
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: sameAppBar(_scaffoldKey, context),
      drawer: sameDrawer(context),
      body: Builder(
        builder: (context) => ListView(
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
            Column(
              children: <Widget>[
                // bannar image
                // profile image
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        bottom: 230,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: CustomColors.Primary,
                              image: DecorationImage(
                                  image: NetworkImage(
                                         image,
                                        ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Container(
                            padding:
                            EdgeInsets.only(right: 10, left: 10,top: 10),
                            width: double.infinity,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                widget.singleDoctor['name'],
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.Primary),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(right: 10, left: 10,top: 10),
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                removeAllHtmlTags(widget.singleDoctor['description']),
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
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
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                LocaleKeys.doctor_field.tr(),
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              Text(
                                removeAllHtmlTags(widget.singleDoctor['description']) ,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: CustomColors.Secondary,
                                ),
                              ),

                            ],
                          ),
                        ),
                      /*  Divider(
                          height: 5.0,
                          color: Colors.grey,
                          thickness: 1.0,
                          endIndent: 2,
                          indent: 2,
                        ),*/
                       /* Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                widget.singleDoctor['address'],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: CustomColors.Secondary,
                                    fontSize: 18),
                              ),
                              Text(
                                'محل الاقامة',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                        ),*/
                        Divider(
                          height: 5.0,
                          color: Colors.grey,
                          thickness: 1.0,
                          endIndent: 2,
                          indent: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.40,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  LocaleKeys.doctor_certif.tr(),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                                _drawCertificate(),
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
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                LocaleKeys.doctor_price.tr(),
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    widget.singleDoctor['price']+'\$',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: CustomColors.Primary,
                                        fontSize: 20),
                                  )),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                MaterialButton(
                  height: 50,
                  minWidth: double.infinity,
                  color: CustomColors.Primary,
                  textColor: Colors.white,
                  onPressed: () {
                    createAlertDialog(
                      context,
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      LocaleKeys.order_doctor.tr(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController contentController = TextEditingController();
    final _doctorKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    LocaleKeys.order_doctor.tr(),
                    style: TextStyle(color: CustomColors.Primary),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            content: Form(
              key: _doctorKey,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      LocaleKeys.paid_method.tr(),
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
                      LocaleKeys.pay_in.tr(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      LocaleKeys.detiels_session.tr(),
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
                      hintText: LocaleKeys.session_detiels_enter.tr(),
                      hintStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Material(
                    color: CustomColors.Primary,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    elevation: 1.0,
                    child: MaterialButton(
                      onPressed: () {
                        if (_doctorKey.currentState.validate()) {
                          bookingDoctor
                              .orderDoctor(widget.singleDoctor["id"],
                                  widget.singleDoctor["price"],contentController.text)
                              .then((value) {
                            if (value["id"] != null) {
                              contentController.clear();
                              final SnackBar mySnakBar = SnackBar(
                                  duration: const Duration(seconds: 3),
                                  content: Text(
                                    LocaleKeys.thankyou_for_doctor.tr(),
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

                            Navigator.pop(context);
                          });
                        }
                      },
                      minWidth: double.infinity,
                      height: 37.0,
                      child: Text(
                        LocaleKeys.send_session.tr(),
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

  Widget _drawCertificate() {
    List<String> imgList = [];
    for(int i =0; i<widget.singleDoctor["images"].length;i++){
      imgList.add(widget.singleDoctor["images"][i]["src"]);
    }


    return imgList.length > 0
        ? Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child:CarouselSlider(
              options: CarouselOptions(
                height: 300,
                viewportFraction: 1,
                enlargeCenterPage: true,
                autoPlay: true,
              ),
              items: imgList
                  .map((item) => Container(
                child: Center(
                    child:
                    Image.network(item, fit: BoxFit.cover, width: 1000)),
              ))
                  .toList(),
            )
    ):Container();
  }
}
