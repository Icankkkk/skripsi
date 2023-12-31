import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:discuss_app/controller/c_my_topic.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:discuss_app/model/topic.dart';
import 'package:discuss_app/source/topic_source.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MyTopicFragment extends StatelessWidget {
  const MyTopicFragment({super.key});

  deleteTopic(BuildContext context, Topic topic) {
    TopicSource.delete(topic.id, topic.images).then((success) {
      if (success) {
        context.read<CMyTopic>().setTopics(topic.idUser);
        DInfo.snackBarSuccess(context, 'Success Delete Topic');
      } else {
        DInfo.snackBarError(context, 'Delete Topic Failed');
      }
    });
  }

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
        Expanded(
          child: Consumer<CMyTopic>(
            builder: (contextConsumer, _, child) {
              if (_.topics.isEmpty) return DView.empty();
              return ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: _.topics.length,
                itemBuilder: (context, index) {
                  Topic topic = _.topics[index];
                  return ListTile(
                    onTap: () => context.push(
                      AppRoute.detailTopic,
                      extra: topic..user = user,
                    ),
                    leading: CircleAvatar(
                      radius: 16,
                      child: Text('${index + 1}'),
                    ),
                    horizontalTitleGap: 0,
                    title: Text(
                      topic.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      topic.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'detail') {
                          context.push(
                            AppRoute.detailTopic,
                            extra: topic..user = user,
                          );
                        }
                        if (value == 'update') {
                          context.push(
                            AppRoute.updateTopic,
                            extra: topic..user = user,
                          );
                        }
                        if (value == 'delete') {
                          DInfo.dialogConfirmation(
                            context,
                            'Delete Topic',
                            'Yes to confirm',
                          ).then((yes) {
                            if (yes ?? false) {
                              deleteTopic(context, topic);
                            }
                          });
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'detail',
                          child: Text('Detail'),
                        ),
                        const PopupMenuItem(
                          value: 'update',
                          child: Text('Update'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
