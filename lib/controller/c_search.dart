import 'package:discuss_app/model/topic.dart';
import 'package:discuss_app/model/user.dart';
import 'package:discuss_app/source/topic_source.dart';
import 'package:discuss_app/source/user_source.dart';
import 'package:flutter/foundation.dart';

class CSearch extends ChangeNotifier {
  List<String> get filters => ['Topic', 'User'];

  String _filter = 'Topic'; // initialitation
  String get filter => _filter;
  set filter(String newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  search(String query) {
    if (filter == 'Topic') {
      setTopics(query);
    } else {
      setUsers(query);
    }
  }

  List<Topic> _topics = [];
  List<Topic> get topics => _topics;
  setTopics(String query) async {
    _topics = await TopicSource.search(query);
    notifyListeners();
  }

  List<User> _users = [];
  List<User> get users => _users;
  setUsers(String query) async {
    _users = await UserSource.search(query);
    notifyListeners();
  }
}
