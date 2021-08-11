import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mylamsy/controller/booking_program_api.dart';
import 'package:mylamsy/screen/home_tabs/tab_mylist.dart';
import 'package:mylamsy/screen/home_tabs/tab_newlist.dart';
import 'package:mylamsy/screen/program/program_details_screen.dart';
import 'package:mylamsy/style/SimilarWidgets.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
class ProgramScreen extends StatefulWidget {
  @override
  _ProgramScreenState createState() => _ProgramScreenState();
}

class _ProgramScreenState extends State<ProgramScreen> {
  BookingProgram bookingProgram;

  @override
  void initState() {
    bookingProgram = BookingProgram();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = context.locale;
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
              future: bookingProgram.getPrograms(locale),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    emptyPage(context);
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
                      return Container(
                        child: Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Text(
                                LocaleKeys.programs.tr(),
                                style: TextStyle(
                                    fontSize: 25,
                                    color: CustomColors.Primary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          GridView.count(
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            primary: true,
                            shrinkWrap: true,
                            // Create a grid with 2 columns. If you change the scrollDirection to
                            // horizontal, this produces 2 rows.
                            crossAxisCount: 2,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            //childAspectRatio: 0.75,
                            // Generate 100 widgets that display their index in the List.
                            children: new List.generate(snapshot.data.length, (index) {
                              return getExpanded(snapshot.data[index]);
                            }),
                          )
                        ]),
                      );
                    } else {
                      emptyPage(context);
                    }
                    break;
                  default:
                    return emptyPage(context);
                }
                return emptyPage(context);
              }),
        ],
      ),
    );
  }

  Widget getExpanded(
    Map map,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProgramDetails(map),
          ),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(map["_embedded"]["wp:featuredmedia"][0]["source_url"]),fit: BoxFit.cover
                )
              ),
              height: 110,
              width: double.infinity,

            ),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                map['title']['rendered'],
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
