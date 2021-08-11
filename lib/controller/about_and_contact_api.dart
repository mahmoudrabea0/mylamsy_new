import 'dart:convert';

import 'package:http/http.dart' as http;

class AboutAndContactUsApi {
  Future<Map> getAboutUs(locale) async {
    var url = Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wp/v2/pages/286?lang=$locale");
    final response = await http.get(url);
//    print(response.body);

    if (response.statusCode == 200) {
      var jason = jsonDecode(response.body);
      return jason;
    }
    return null;
  }
  Future<Map> getContactUS(locale) async {
    var url = Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wp/v2/pages/273?lang=$locale");
    final response = await http.get(url);
//    print(response.body);

    if (response.statusCode == 200) {
      var jason = jsonDecode(response.body);
      return jason;
    }

  }

}
