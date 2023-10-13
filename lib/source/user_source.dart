import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:http/http.dart';

import '../config/api.dart';

class UserSource {
  static Future<Map> register(String username, String pasword) async {
    String url = '${Api.user}/register.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'username': username,
        'password': pasword,
      });
      DMethod.printTitle('User Source -  register', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      DMethod.printTitle('User Source - register', e.toString());
      return {'success': false};
    }
  }

  static Future<Map> login(String username, String pasword) async {
    String url = '${Api.user}/register.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'username': username,
        'password': pasword,
      });
      DMethod.printTitle('User Source -  login', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      DMethod.printTitle('User Source - login', e.toString());
      return {'success': false};
    }
  }
}
