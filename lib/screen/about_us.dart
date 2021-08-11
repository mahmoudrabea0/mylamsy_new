import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mylamsy/controller/about_and_contact_api.dart';
import 'package:mylamsy/screen/drawer_widget.dart';
import 'package:mylamsy/style/SimilarWidgets.dart';
import 'package:easy_localization/easy_localization.dart';
import '../translations/locale_keys.g.dart';
class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  GlobalKey<ScaffoldState> aboutUSKey = new GlobalKey<ScaffoldState>();
  AboutAndContactUsApi aboutAndContactUsApi = AboutAndContactUsApi();

  @override
  Widget build(BuildContext context) {
    var locale = context.locale;
    return Scaffold(
      key: aboutUSKey,
      backgroundColor: Colors.white,
      appBar: sameAppBar(aboutUSKey, context),
      drawer: sameDrawer(context),
      body: FutureBuilder(
          future: aboutAndContactUsApi.getAboutUs(locale),
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
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          LocaleKeys.about_us.tr(),
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        // Container Icon Image
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10.0),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "images/logo_icon.png",
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Html(
                          data: snapshot.data['title']['rendered'],
                          //Optional parameters:
                          backgroundColor: Colors.white70,
                          customTextStyle: (node, TextStyle baseStyle) {
                            return TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                            );
                          },
                          customTextAlign: (_) => TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Html(
                            data: snapshot.data['content']['rendered'],
                            //Optional parameters:
                            backgroundColor: Colors.white70,
                            customTextStyle: (node, TextStyle baseStyle) {
                              return TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              );
                            },
                            customTextAlign: (_) => TextAlign.center,
                          ),
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
    );
  }
}
