import 'dart:convert';

class Notification_class {
  final String product_id, term_name;


  Notification_class({
    this.product_id,
    this.term_name,
  });

  factory Notification_class.fromJson(Map<String, dynamic> jsonData) {
    return Notification_class(
      product_id: jsonData['product_id'],
      term_name: jsonData['term_name'],
     
    );
  }

  static Map<String, dynamic> toMap(Notification_class Notification_class) => {
    'product_id': Notification_class.product_id,
    'term_name': Notification_class.term_name,
  };

  static String encode(List<Notification_class> Notification_classs) => json.encode(
    Notification_classs
        .map<Map<String, dynamic>>((Notification_classs) => Notification_class.toMap(Notification_classs))
        .toList(),
  );

  static List<Notification_class> decode(String Notification_classs) =>
      (json.decode(Notification_classs) as List<dynamic>)
          .map<Notification_class>((item) => Notification_class.fromJson(item))
          .toList();
}