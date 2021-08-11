import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mylamsy/style/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mylamsy/translations/locale_keys.g.dart';
File image;
final picker = ImagePicker();

class ImagePikeScreen extends StatefulWidget {
  @override
  _ImagePikeScreenState createState() => _ImagePikeScreenState();
}

class _ImagePikeScreenState extends State<ImagePikeScreen> {
  final GlobalKey<ScaffoldState> userUploadImageKey =
  new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: userUploadImageKey,
      appBar: AppBar(
        title: Text(
          LocaleKeys.upload_image.tr(),
          style: TextStyle(
              color: CustomColors.Reverse,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.Primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getImage();
          });
        },
        backgroundColor: CustomColors.Primary,
        child: Icon(Icons.image),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          image == null
              ? Container(
            child: Center(
              child: Text(
                "من فضلك ادخل الصورة الخاصة بك",
                style: TextStyle(
                  letterSpacing: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
              : Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery
                    .of(context)
                    .size
                    .height * 0.5,
              ),
              child: DrawTakerImageBox(image)),
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.1,
          ),
          _drawButtonToSubmitOrReset()
        ],
      ),
    );
  }

  Widget _drawButtonToSubmitOrReset() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery
            .of(context)
            .size
            .width * .8,
        maxHeight: MediaQuery
            .of(context)
            .size
            .height * 0.21,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            onTap: () async {
              SnackBar mySnakBar = SnackBar(
                  content: Text(
                      "لم يتم اكمال ارسال الصورة من فضلك حاول مرة اخره"));
              userUploadImageKey.currentState.showSnackBar(mySnakBar);
            },
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .4,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.07,
              decoration: BoxDecoration(
                color: CustomColors.Primary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "ارسال",
                  style: TextStyle(
                      color: CustomColors.Reverse,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                image = null;
              });
            },
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * .4,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.07,
              decoration: BoxDecoration(
                color: CustomColors.Primary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "مسح",
                  style: TextStyle(
                      color: CustomColors.Reverse,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}

class DrawTakerImageBox extends StatefulWidget {
  File image;

  DrawTakerImageBox(this.image);

  @override
  _DrawTakerImageBoxState createState() => _DrawTakerImageBoxState();
}

class _DrawTakerImageBoxState extends State<DrawTakerImageBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery
            .of(context)
            .size
            .width * .45,
        height: MediaQuery
            .of(context)
            .size
            .height * .55,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: Image.file(
            widget.image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
