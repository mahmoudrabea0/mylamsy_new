import 'dart:convert';

class ApiPaths {
  static String mainApi = "https://demo.mahacode.com/mylamesy";
  static String userDetails = mainApi + "/user";

  static String login = mainApi + "/api/user/generate_auth_cookie";
  static String signUp = mainApi + "/wp-json/wp/v2/users";
  static String facebookLog = mainApi + "/wp-json/wp/v2/user/fb_connect";
  static String allDoctors = mainApi + "/wp-json/wp/v2/doctors";
  static final auth = 'Basic ' + base64Encode(utf8.encode(
      'ck_3641728b896f85302e878fba3fe6b3b3b9f71281:cs_a344bac4b241070c5b45b26e06fb5c4de10db8d6'));
  static String allPrograms = mainApi + "wp-json/wp/v2/posts";

  static String updateProfile = mainApi + "/updateprofile";
  static String allServices = mainApi + "/allservices";
  static String randomUsers = mainApi + "/users";
  static String randomServices = mainApi + "/randomservices";

  static String servicescategory(int id) {
    return mainApi + "/servicescategory/$id";
  }

  static String singleDoctor(int id) {
    return mainApi + "wp-json/wc/v3/products?category=${id.toString()}";
  }

  static String makeOrder = mainApi + "/makeorder";
}
