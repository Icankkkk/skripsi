import 'package:d_view/d_view.dart';
import 'package:discuss_app/controller/c_my_topic.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTopicFragment extends StatelessWidget {
  const MyTopicFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<CUser>().data;
    context.read<CMyTopic>().setTopics(user!.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: DView.textTitle('My Topic', size: 24),
        ),
      ],
    );
  }
}
