import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylamsy/controller/about_and_contact_api.dart';
import 'package:mylamsy/style/SimilarWidgets.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import 'drawer_widget.dart';

class ContactUS extends StatefulWidget {
  @override
  _ContactUSState createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  GlobalKey<ScaffoldState> contactUSKey = new GlobalKey<ScaffoldState>();
  AboutAndContactUsApi aboutAndContactUsApi = AboutAndContactUsApi();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var locale=context.locale;
    return Scaffold(
      key: contactUSKey,
      backgroundColor: Colors.white,
      appBar: sameAppBar(contactUSKey, context),
      drawer: sameDrawer(context),
      body: FutureBuilder(
          future: aboutAndContactUsApi.getContactUS(locale),
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
                         LocaleKeys.be_with_us.tr() ,
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          LocaleKeys.be_with_us.tr(),
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // TextField Phone Number
                        _drawContactInfo(
                          snapshot.data["phone_number"],
                          Icons.call,
                        ),
                        _drawContactInfo(
                          snapshot.data["email"],
                          Icons.email,
                        ),
                        _drawContactInfo(
                          snapshot.data["address"],
                          Icons.location_on,
                        ),

                        // TextField Maps
                        // All Icons
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Linkedin Icon
                              _drawSocialImage(
                                  "linked",
                                  'images/linkedin.png',
                                  snapshot.data["linkedin_link"],
                                  Color(0xff0077b4)),
//
                              SizedBox(
                                width: 10.0,
                              ),
                              _drawSocialImage(
                                  "insta",
                                  'images/instagram.png',
                                  snapshot.data["instgram_link"],
                                  Colors.purple), // Instagram Icon

                              SizedBox(
                                width: 10.0,
                              ),

                              // Twitter Icon
                              _drawSocialImage("twitter", 'images/twitter.png',
                                  snapshot.data["twitter_link"], Colors.blue),

                              SizedBox(
                                width: 10.0,
                              ),

                              // Facebook Icon
                              _drawSocialImage(
                                  "facebook",
                                  'images/facebook.png',
                                  snapshot.data["facebook_link"],
                                  Colors.blueAccent),

                              SizedBox(
                                width: 10.0,
                              ),

                              // WhatsApp Icon
                              _drawSocialImage(
                                  "whatsapp",
                                  'images/whatsapp.png',
                                  snapshot.data["whasapp_number"],
                                  Colors.green),
                            ],
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * .25,
                          child: WebView(
                            initialUrl: Uri.dataFromString(
                                    snapshot.data["map_link"],
                                    mimeType: 'text/html')
                                .toString(),
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

  Widget _drawContactInfo(String info, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black45),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * .7,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * .7,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 12,
                    ),
                    child: Text(
                      info,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                width: 60,
                color: Colors.lightGreen,
                child: Icon(
                  icon,
                  size: 35,
                  color: Colors.black54,
                )),
          ],
        ),
      ),
    );
  }

  Widget _drawSocialImage(
    String name,
    String image,
    String map,
    Color color,
  ) {
    return InkWell(
      onTap: () {
        switch (name) {
          case "whatsapp":
            _launchWhatsURL(
              map,
//              ["whasapp_number"],
            );
            break;
          case "facebook":
            _launchFaceURL(map
//            ["facebook_link"]
                );
            break;
          case "twitter":
            _launchTwitterURL(map
//            ["twitter_link"]
                );
            break;
          case "insta":
            _launchInstagramURL(map
//            ["instgram_link"]
                );
            break;
          case "linked":
            _launchLinkedInURL(map
//            ["linkedin_link"]
                );
            break;
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .14,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image:
              DecorationImage(image: ExactAssetImage(image), fit: BoxFit.cover),
        ),
      ),
    );
  }

  _launchWhatsURL(String phone) async {
    var whatsappUrl = "whatsapp://send?phone=$phone";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : showDialogWidget(LocaleKeys.there_is_no_whatapp.tr(), context);
  }

  _launchFaceURL(String profile) async {
    var faceBookUrl = profile;
    await canLaunch(faceBookUrl)
        ? launch(
            faceBookUrl,
          )
        : showDialogWidget(LocaleKeys.we_found_error.tr(), context);
  }

  _launchInstagramURL(String profile) async {
    var instagramUrl = profile;
    await canLaunch(instagramUrl)
        ? launch(
            instagramUrl,
          )
        : showDialogWidget(LocaleKeys.we_found_error.tr(), context);
  }

  _launchTwitterURL(String twitterUrl) async {
    var instagramUrl = twitterUrl;
    await canLaunch(instagramUrl)
        ? launch(
            instagramUrl,
            forceSafariVC: true,
          )
        : showDialogWidget(LocaleKeys.we_found_error.tr(), context);
  }

  _launchLinkedInURL(String phone) async {
    var viperUrl = phone;
    await canLaunch(viperUrl)
        ? launch(
            viperUrl,
          )
        : showDialogWidget(LocaleKeys.there_is_no_whatapp.tr(), context);
  }

  void showDialogWidget(String str, BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          //title: new Text("Alert Dialog title"),
          content: new Text(str),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
