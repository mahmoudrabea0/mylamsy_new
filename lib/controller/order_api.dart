import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllOrdersApi {
  final auth = 'Basic ' +
      base64Encode(utf8.encode(
          'mostapha94:6060660'));

  Future<List> getAllDoctorOrders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id");
    final response = await http.get(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wc/v3/orders/$id"),
        headers: {"authorization": auth});
    print(response.body);
    if (response.statusCode == 200) {
      var jason = jsonDecode(response.body);
      return jason;
    }
    return null;
  }

  Future<List> getAllMealOrders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id");
    final response = await http.post(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wc/v3/orders"),
        body: jsonEncode({
          "customer_id": id
        }),
        headers: {'content-type': 'application/json',
    'accept': 'application/json',"authorization": auth});
    print(response.body);
    if (response.statusCode == 200) {
      var jason = jsonDecode(response.body);
      return jason;
    }
    return null;
  }


  Future<List> getAllProductsOfcustomer(products_id) async {
    List breakfast=[];
    List launch=[];
    List dinner=[];
    print(products_id.toString());
    String d = products_id.toString().replaceAll(']', "").replaceAll('[', "");
    final response = await http.get(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wc/v3/products?include=$d&per_page=50"),
        headers: {
          'Authorization': auth,
        });
//    print(response.body);
    if (response.statusCode == 200) {
      var jason = jsonDecode(response.body);
      print("kljl"+jason.toString());

      for(int i = 0;i<jason.length;i++){
        print(jason[i]["categories"][0]['id']) ;
        //الغداء
        if(jason[i]["categories"][0]['id']==20){
          launch.add(jason[i]);
        }else if(jason[i]["categories"][0]['id']==15){
          dinner.add(jason[i]);
        }else{
          breakfast.add(jason[i]);
        }
      }
      //var x = [breakfast,launch,dinner].expand((e) => e).toList();
//print("tuctyu"+x.toString());
      return [breakfast,launch,dinner].expand((e) => e).toList();
    }
    return null;
  }

  Future<List> getordersOfSinglecustomer() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id");
    final response = await http.get(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wc/v3/orders?customer=$id&per_page=50"),
        headers: {"authorization": auth});
//    print(response.body);
    if (response.statusCode == 200) {
      var jason = jsonDecode(response.body);
      List products_id=[];

      for(int i = 0; i<jason.length;i++){
        products_id.add(jason[i]["line_items"][0]["product_id"]);
      }
      print("ghhhhh"+products_id.toString());
      if(products_id.isEmpty){
        return null;
      }else{
        return getAllProductsOfcustomer(products_id);
      }

    }
    return null;
  }
}
