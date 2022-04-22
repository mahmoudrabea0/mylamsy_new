import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mylamsy/utilities/api_paths.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final auth = 'Basic ' + base64Encode(utf8.encode('mostapha94:6060660'));

  Future<String> logIn(
      BuildContext context, String userName, String password) async {
    var url = Uri.parse(ApiPaths.login);
    Map<String, dynamic> user = {
      'username': userName,
      'password': password,
    };
    var response = await http.post(url, body: user);
    if (response.statusCode == 200) {
      try {
        var json = jsonDecode(response.body);
        var data = json;
        if (data['status'] == "ok") {
          await setId(data["user"]["id"].toString());
          await setName(userName.toString());

          //await setToken(data["cookie"].toString());
          await setPassword(password);
        }
        return data['status'];
      } catch (Exception) {
        return "not found";
      }
    }
    return "not found";
  }

  Future<String> logInWithFacebook(
    BuildContext context,
    String token,
  ) async {
    var response = await http.post(
        Uri.parse("https://demo.mahacode.com/mylamesy/api/user/fb_connect"),
        body: {"access_token": "$token"});
    print(response.body);
    if (response.statusCode == 200) {
      try {
        var json = jsonDecode(response.body);
        var data = json;
//        if (data['status'] == "ok") {
//          await setId(data["user"]["id"].toString());
//          await setName(userName.toString());
//
//          await setToken(data["cookie"].toString());
//          await setPassword(password);
//        }
        return data['status'];
      } catch (Exception) {
        return "not found";
      }
    }
    return "not found";
  }

  Future<Map> signUpAsClient(
    BuildContext context,
    String firstName,
    String lastName,
    String userName,
    String email,
    String password,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token');
    Map<String, dynamic> user = {
      'username': userName,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,

    };

    var response = await http.post(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wp/v2/users"),
        body: user,
        headers: {"Authorization": auth});
    print(response.body);
   // if (response.statusCode == 201) {
      var json = jsonDecode(response.body);
      setId(json["id"].toString());
      setName(userName.toString());
      setToken(json["cookie"].toString());
      setPassword(password);
      return json;
   // }
   // return null;
  }

  Future getAnUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id");
    print(id);
    var response = await http.get(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wp/v2/users/$id"),
        headers: {"authorization": auth,'accept': 'application/json','content-type': 'application/json',});
    print(response.body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(response.body);
      var data = json;
      return data;
    }
  }

  Future upgradeAnUser(
    String name,
    description,
    city,
    address,
    email,
    phoneNumber,
  ) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id");


    var url = Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wp/v2/users/$id");
    String token = pref.getString('token');
    print("TOKEN"+token);
    var response =
        await http.post(url, body: jsonEncode({
          "description":description,
          "meta": {
            "address" : address,
            "phone_number" : phoneNumber,
            "city" : city,
            "token": token,
          }
        }), headers: {'authorization': auth,
          'accept': 'application/json','content-type': 'application/json',});
    print(response.body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      await setId(json["id"].toString());
      await setToken(json["id"].toString());
      if (json["id"] != null) {
        return "done";
      }
      return 'error';
    }
    return "not found";
  }

  Future completeUserData(String country, city, address, phoneNumber, description) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id");
    var url = Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wp/v2/users/$id");
    var user = jsonEncode({
      'meta':{
        'address': address,
        'phone_number': phoneNumber,
        'city': city,
        'description': description,
        'country': country
      },
    });

    print("data"+user.toString());
    var response =
        await http.post(url, body: user, headers: {"authorization": auth,'content-type': 'application/json',
          'accept': 'application/json'});
    print(response.body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      await setId(json["id"].toString());
      await setToken(json["id"].toString());
      if (json["id"] != null) {
        return "done";
      }
      return 'error';
    }
    return "not found";
  }
   upgradeTokenUser(token) async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id");
    //String token = pref.getString('token');

    var url = Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wp/v2/users/$id");

    print("TOKEN"+token);
    var response =
    await http.post(url, body: jsonEncode({
      "meta": {
        "token": token,
      }
    }), headers: {'authorization': auth,
      'accept': 'application/json','content-type': 'application/json',});
    print(response.body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      await setId(json["id"].toString());
      await setToken(json["id"].toString());
      if (json["id"] != null) {
        return "done";
      }
      return 'error';
    }
    return "not found";
  }
}

setId(String id) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  await preferences.setString("id", id);
  print('id is change');
}

setToken(String token) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString("token", token);
}

setPassword(String password) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString("pass", password);
}

setName(String name) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString("name", name);
}
