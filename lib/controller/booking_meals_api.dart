import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingMeal {
  final auth = 'Basic ' + base64Encode(utf8.encode('mostapha94:6060660'));

  Future setMealsToSpecial(title, content) async {
    SharedPreferences pref =
    await SharedPreferences.getInstance();
    String authorId = pref.getString("id");
    final response = await http.post(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wp/v2/special_meals"),
        body: {
          "title": title,
          "author": authorId,
          "content": content
        },
        headers: {
          'Authorization': auth,
        });

    print(response.body);
    if (response.statusCode == 201) {
      var jason = jsonDecode(response.body);
      return jason;
    }
    return null;
  }

  Future<List> getAllProductsCustomer(products_id) async {
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

  Future<List> getAllSpecialMealsCustomer() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id");
    final response = await http.post(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wp/v2/get_product_by_user_id"),body: {
          "user_id":id
    },
        headers: {"authorization": auth});
//    print(response.body);
    if (response.statusCode == 200) {
      var jason = jsonDecode(response.body);


      for(int i = 0; i<jason.length;i++){

      }
      if(jason.isEmpty){
        return null;
      }else{
        return getAllProductsCustomer(jason);
      }

    }
    return null;
  }

  Future orderMeals(
  orderdata,
  typeMealControlle,
  addressController,
  firstDate ,
  lastDate ,
  timeController ,
  commentController
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString("id");
    print(id.toString());
    print(orderdata.toString());
String customer_note = "firsttime"+firstDate+"lasttitme"+lastDate+"time"+timeController;
    var response = await http.post(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wc/v3/orders"),
      body: jsonEncode({
        "set_paid": false,
        'shipping':{
          'address_1' : addressController,
        },
        "customer_id": id,
        "line_items": [
          {
            "product_id": orderdata['id'],
            "quantity": 1
          },
        ],
        "customer_note":customer_note
      },),
        headers: {'content-type': 'application/json',
          'accept': 'application/json',"authorization": auth}
    );
    print(response.body);

    if (response.statusCode == 201) {
      print(response.statusCode);

      var json = jsonDecode(response.body);
      return json;
    }
    print("json");
    return null;
  }
  Future<List> getMealsBySearch(mealName,locale) async {
    final response = await http.get(
        Uri.parse("https://demo.mahacode.com/mylamesy/wp-json/wc/v3/products?search=$mealName&lang=$locale"),
        headers: {
          'Authorization': auth,
        });
//    print(response.body);
    if (response.statusCode == 200) {
      var jason = jsonDecode(response.body);
      return jason;
    }
    return null;
  }
}
