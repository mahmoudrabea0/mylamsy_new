import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingDoctor {
  final auth ='Basic ' + base64Encode(utf8.encode('mostapha94:6060660'));

  Future<List> getDoctors(locale) async {
    var response = await http.get(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wc/v3/products?category=24&lang=$locale"),
        headers: {"Accept": "application/json","authorization": auth});
//    print(response.body);
    if (response.statusCode == 200) {
      var jason = jsonDecode(response.body);
      return jason;
    }
  }
  Future<List> getMeals(locale,cat_id) async {
    var response = await http.get(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wc/v3/products?category=${cat_id}&per_page=45&lang=$locale"),
        headers: {"Accept": "application/json","authorization": auth});
//    print(response.body);
    if (response.statusCode == 200) {
      var jason = jsonDecode(response.body);
      return jason;
    }
  }
  Future<List> getcategroies(locale) async {
    var response = await http.get(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wc/v3/products/categories?per_page=45&parent=0&lang=$locale&exclude=24,25"),
        headers: {"Accept": "application/json","authorization": auth});
//    print(response.body);
    if (response.statusCode == 200) {
      var jason = jsonDecode(response.body);
      return jason;
    }
  }

  Future orderDoctor(doctorId, doctorPrice,content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var datId = prefs.get("id");
    print(datId);
    print(doctorId.toString());
    print(doctorPrice);
    var response = await http.post(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wc/v3/orders"),
        body: jsonEncode({
          "set_paid": false,
          "customer_id": datId,
          "line_items": [
            {
              "product_id": doctorId,
              "quantity": 1
            },
          ],
          "customer_note":content
        },),
        headers: {'content-type': 'application/json',
          'accept': 'application/json',"authorization": auth});
    print(response.body);

    if (response.statusCode == 201) {
      print(response.statusCode);

      var json = jsonDecode(response.body);
      print(json);
      return json;
    }
    return null;
  }
}
