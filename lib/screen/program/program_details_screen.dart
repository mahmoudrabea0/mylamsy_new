import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mylamsy/screen/home_tabs/tab_mylist.dart';
import 'package:mylamsy/screen/home_tabs/tab_newlist.dart';
import 'package:mylamsy/screen/main_screen.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import '../drawer_widget.dart';

class ProgramDetails extends StatefulWidget {
  Map singleProgram;

  ProgramDetails(this.singleProgram);

  @override
  _ProgramDetailsState createState() => _ProgramDetailsState();
}

class _ProgramDetailsState extends State<ProgramDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int index;

  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: sameAppBar(scaffoldKey, context),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: (widget.singleProgram["_embedded"]["wp:featuredmedia"][0]
                          ["source_url"] ==
                      null)
                  ? Image.asset(
                      "assets/images/logo.png",
                    )
                  : Image(
                      loadingBuilder:
                          (context, image, ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) {
                          return image;
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      image: NetworkImage(
                        widget.singleProgram["_embedded"]["wp:featuredmedia"][0]
                            ["source_url"],
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.singleProgram['title']['rendered'],
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  )),
            ),
            Divider(
              height: 3.0,
              color: Colors.grey,
              thickness: 1.0,
              endIndent: 15.0,
              indent: 15.0,
            ),
          /*  Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Html(
                    data: widget.singleProgram["_embedded"]["author"][0]
                        ["description"],
                    //Optional parameters:
                    backgroundColor: Colors.white70,
                    customTextStyle: (node, TextStyle baseStyle) {
                      return TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      );
                    },
                    customTextAlign: (_) => TextAlign.right,
                  )
//                child: Text(widget.singleProgram['content']['rendered'], style: TextStyle(fontSize: 17, color: Colors.grey, fontWeight: FontWeight.bold),)
                  ),
            ),*/
            SizedBox(
              height: 30,
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            //   child: Align(
            //       alignment: Alignment.centerRight,
            //       child: Text(
            //         'قائمة علامات افتراضية',
            //         style: TextStyle(
            //             fontSize: 25,
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold),
            //       )),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Html(
                      data: widget.singleProgram['content']['rendered'],
                      //Optional parameters:
                      backgroundColor: Colors.white70,
                      customTextStyle: (node, TextStyle baseStyle) {
                        return TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54);
                      },
                      customTextAlign: (_) => TextAlign.right,
                    ),
                  )
                ],
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