import 'package:discuss_app/model/comment.dart';
import 'package:discuss_app/model/topic.dart';
import 'package:flutter/foundation.dart';

class CComment extends ChangeNotifier {
  final List<Comment> _comments = [];
  List<Comment> get comments => _comments;
  setComments(Topic topic) async {
    _image = '';
    _imageBase64code = '';
  }

  String _image = '';
  String get image => _image;

  String _imageBase64code = '';
  String get imageBase64code => _imageBase64code;
}
