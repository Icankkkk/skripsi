import 'dart:convert';

import 'package:d_method/d_method.dart';
import 'package:discuss_app/config/api.dart';
import 'package:discuss_app/model/topic.dart';
import 'package:http/http.dart';

class TopicSource {
  static Future<bool> create(
    String title,
    String description,
    String images,
    String base64codes,
    String idUser,
  ) async {
    String url = '${Api.topic}/create.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'title': title,
        'description': description,
        'images': images,
        'base64codes': base64codes,
        'id_user': idUser,
      });
      DMethod.printTitle('Topic Source - create', response.body);
      Map responseBody = jsonDecode(response.body);
      return responseBody['success'];
    } catch (e) {
      DMethod.printTitle('Topic Source - create', e.toString());
      return false;
    }
  }

  static Future<List<Topic>> readWhereIdUser(String idUser) async {
    String url = '${Api.topic}/read_where_id_user.php';
    try {
      Response response = await Client().post(Uri.parse(url), body: {
        'id_user': idUser,
      });
      DMethod.printTitle('Topic Source - readWhereIdUser', response.body);
      Map responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        List list = responseBody['data'];
        return list.map((e) {
          Map<String, dynamic> item = Map<String, dynamic>.from(e);
          return Topic.fromJson(item);
        }).toList();
      }
      return [];
    } catch (e) {
      DMethod.printTitle('Topic Source - readWhereIdUser', e.toString());
      return [];
    }
  }
}
