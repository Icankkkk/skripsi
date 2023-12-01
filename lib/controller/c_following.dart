import 'package:discuss_app/model/user.dart';
import 'package:discuss_app/source/follow_source.dart';
import 'package:flutter/foundation.dart';

class CFollowing extends ChangeNotifier {
  List<User> _list = [];
  List<User> get list => _list;
  setList(String idUser) async {
    _list = await FollowSource.readFollowing(idUser);
    notifyListeners();
  }
}
