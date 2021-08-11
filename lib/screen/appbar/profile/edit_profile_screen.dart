import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mylamsy/controller/auth_Api.dart';
import 'package:mylamsy/screen/appbar/profile/image_upload_screen.dart';
import 'package:mylamsy/utilities/preferences.dart';

import '../../drawer_widget.dart';
import 'profile_screen.dart';
class EditProfileScreen extends StatefulWidget {
  Map map;

  EditProfileScreen(this.map);



  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<ScaffoldState> editProfileKey =
      new GlobalKey<ScaffoldState>();
  Authentication auth = Authentication();
  TextEditingController nameController;
  TextEditingController descriptionController;
  TextEditingController emailController;
  TextEditingController cityController;
  TextEditingController addressController;
  TextEditingController phoneController;

  @override
  void initState() {
    nameController = TextEditingController()..text=widget.map['name'];
    descriptionController = TextEditingController()..text=widget.map['description'];
    emailController = TextEditingController()..text=widget.map["user_email"];
    cityController = TextEditingController()..text=widget.map["meta"]["city"];
    addressController = TextEditingController()..text=widget.map["meta"]["address"];
    phoneController = TextEditingController()..text=widget.map["meta"]["phone_number"];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Authentication auth = Authentication();
    return Scaffold(
        backgroundColor: Colors.white,
        key: editProfileKey,
        appBar: sameAppBar(editProfileKey, context),
        drawer: sameDrawer(context),
        body: drawUserDetails());
  }

  Widget drawUserDetails() {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * .37,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    bottom: 200,
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
                  Positioned(
                    top: 30,
                    bottom: 180,
                    right: 130,
                    left: 130,
                    child: CircleAvatar(
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImagePikeScreen()));
                          },
                          child: image == null
                              ? (widget.map["meta"]["user_photo"] == null ||
                                      widget.map["meta"]["user_photo"] == "")
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
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      },
                                      image: NetworkImage(
                                        widget.map["meta"]["user_photo"],
                                      ),
                                      fit: BoxFit.contain,
                                    )
                              : Image.file(
                                  image,
                                )),
                      radius: 30,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 25,
                    right: 10,
                    left: 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Align(
                            alignment: Alignment.center,
                            child: _drawTextField(
                                nameController, widget.map['name'], 1),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: _drawTextField(descriptionController,
                                widget.map["description"], 3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
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
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: _drawTextField(
                                emailController, widget.map["user_email"], 1),
                          ),
                          Text(
                            'البريد الالكتروني',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
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
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: _drawTextField(
                                cityController, widget.map["meta"]["city"], 1),
                          ),
                          Text(
                            'محل الاقامة',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
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
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: _drawTextField(addressController,
                                widget.map["meta"]["address"], 1),
                          ),
                          Text(
                            'عنوان الشحن',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
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
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: _drawTextField(phoneController,
                                widget.map["meta"]["phone_number"], 1),
                          ),
                          Text(
                            'رقم الهاتف',
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 5.0,
                      color: Colors.grey,
                      thickness: 1.0,
                      endIndent: 2,
                      indent: 2,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.085,
            ),
            MaterialButton(
              height: 60,
              minWidth: double.infinity,
              color: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                auth.upgradeAnUser(
                        nameController.text,
                        descriptionController.text,
                        cityController.text,
                        addressController.text,
                        emailController.text,
                        phoneController.text,)
                    .then((onValue) {
                  if (onValue == 'done') {
                    final SnackBar mySnakBar = SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Text(
                          "تم تحديث البيانات شكرا لك",
                          textAlign: TextAlign.center,
                        ));
                    editProfileKey.currentState.showSnackBar(mySnakBar);
                    setState(() {
                      Navigator.pop(context);
                      navigateTo(context, ProfileScreen());
                    });
                  /*  setState(() {
                      nameController.clear();
                      descriptionController.clear();
                      cityController.clear();
                      addressController.clear();
                      emailController.clear();
                      phoneController.clear();
                    });*/
                  } else {
                    final SnackBar mySnakBar = SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Text(
                          "نعتذر لم يكتمل التحديث.. تاكد من الاتصال من الانترنت و انك قمت باحداث تغيير فى البيانات",
                          textAlign: TextAlign.center,
                        ));
                    editProfileKey.currentState.showSnackBar(mySnakBar);
                  }
                });
              },
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'حفظ التعديل',
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
    );
  }

  Widget _drawTextField(
      TextEditingController controller, String hintText, int lien) {

    print("نلبنمل"+controller.text);
    return TextField(
      controller: controller,
      autofocus: false,
      maxLines: lien,
      cursorColor: Colors.black,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.black45,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.black45,
            ),
          ),
          hintStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
    );
  }
}
