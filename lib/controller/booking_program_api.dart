import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mylamsy/utilities/api_paths.dart';

class BookingProgram {

  Future<List> getPrograms(locale) async {
    var url = Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wp/v2/posts?_embed&lang=$locale");
    final response = await http.get(url);
//    print(response.body);

    if (response.statusCode == 200) {
      var jason = jsonDecode(response.body);
      return jason;
    }
  }

  Future<String> signUpAsClient(
    String firstName,
    lastName,
    userName,
    email,
    password,
  ) async {
    var url =Uri.parse(ApiPaths.signUp);
    Map<String, dynamic> user = {
      'username': userName,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
    };
    var response = await http.post(url, body: user);
    if (response.statusCode == 200) {
      try {
        var json = jsonDecode(response.body);
        var data = json;
//        print(data);
        if (data['id'] = !null) {}
        return data;
      } catch (Exception) {
        return "not found";
      }
    }
    return "not found";
  }
}
