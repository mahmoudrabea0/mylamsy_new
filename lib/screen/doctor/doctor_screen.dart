import 'package:flutter/material.dart';
import 'package:mylamsy/controller/booking_doctor_api.dart';
import 'package:mylamsy/screen/doctor/doctor_profile.dart';
import 'package:mylamsy/screen/home_tabs/tab_mylist.dart';
import 'package:mylamsy/screen/home_tabs/tab_newlist.dart';
import 'package:mylamsy/shared/commponent.dart';
import 'package:mylamsy/style/SimilarWidgets.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
class DoctorScreen extends StatefulWidget {
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  BookingDoctor bookingDoctor;

  @override
  void initState() {
    bookingDoctor = BookingDoctor(); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale=context.locale;
    return Scaffold(
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
              future: bookingDoctor.getDoctors(locale),
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
                    ));
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(
                                  LocaleKeys.doctor_list.tr(),
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: CustomColors.Primary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.72,
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, pos) {
                                    return itemContainer(
                                        context, snapshot.data[pos]);
                                  }),
                            ),
                          ],
                        ),
                      );
                    }
                    return emptyPage(context);
                    break;
                }
                return emptyPage(context);
              }),
        ],
      ),
    );
  }

  Widget itemContainer(BuildContext context, Map map) {
    String image;
    try{image =map['images'][0]['src'];}catch(e){
      image = "https://via.placeholder.com/150";
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorProfile(map),
            ),
          );
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(9),
                    bottomLeft: Radius.circular(9),
                  ),
                  child: Container(
                    child: (image ==
                        null)
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          map["name"],
                          style: TextStyle(
                              fontSize: 20,
                              color: CustomColors.SecondaryHover,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                         removeAllHtmlTags(map["description"]) ,
                          maxLines: 2,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            LocaleKeys.doctor_price.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
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
                          onPressed: () {},
                          color: Colors.white,
                          child: Text(
                            map['price']+"\$",
                            style: TextStyle(
                                color: CustomColors.Primary, fontSize: 18),
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
