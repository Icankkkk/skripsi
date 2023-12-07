import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/api.dart';
import 'package:discuss_app/config/app_color.dart';
import 'package:discuss_app/config/app_format.dart';
import 'package:discuss_app/controller/c_comment.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:discuss_app/model/comment.dart';
import 'package:discuss_app/model/topic.dart';
import 'package:discuss_app/source/comment_source.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({super.key, required this.topic});
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    final cComment = context.read<CComment>();
    final cUser = context.read<CUser>();
    final controllerInput = TextEditingController();
    cComment.setComments(topic);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              topic.user!.username,
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Consumer<CComment>(
            builder: (contextConsumer, _, child) {
              if (_.comments.isEmpty) {
                return DView.empty('this topic not have comment yet');
              }
              return ListView.builder(
                itemCount: _.comments.length,
                itemBuilder: (context, index) {
                  Comment comment = _.comments[index];
                  return Container(
                    margin: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 16 : 8,
                      16,
                      index == _.comments.length - 1 ? 80 : 8,
                    ),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xffDDDDDD),
                          blurRadius: 16.0,
                          spreadRadius: 1.0,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                            '${Api.imageUser}/${comment.fromUser.image}',
                          ),
                        ),
                        DView.spaceWidth(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    comment.fromUser.username,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (comment.toUser.id != topic.idUser)
                                    const Text(
                                      'to',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  if (comment.toUser.id != topic.idUser)
                                    Text(
                                      comment.toUser.username,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  const Spacer(),
                                  Text(
                                    AppFormat.publish(comment.createdAt),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              DView.spaceHeight(4),
                              Text(comment.description),
                              if (comment.image != '') DView.spaceHeight(8),
                              if (comment.image != '')
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (contextDialog) {
                                        return Column(
                                          children: [
                                            DView.spaceHeight(),
                                            DButtonCircle(
                                              diameter: 40,
                                              onClick: () =>
                                                  Navigator.pop(contextDialog),
                                              child: const Icon(Icons.clear),
                                            ),
                                            Expanded(
                                              child: InteractiveViewer(
                                                child: Image.network(
                                                  '${Api.imageComment}/${comment.image}',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      '${Api.imageComment}/${comment.image}',
                                      height: 200,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        cComment.setReplyTo(comment.fromUser);
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(Icons.reply, size: 13),
                                          Text(
                                            'Reply',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (cUser.data!.id == comment.fromIdUser)
                                      DView.spaceWidth(12),
                                    if (cUser.data!.id == comment.fromIdUser)
                                      GestureDetector(
                                        onTap: () {
                                          CommentSource.delete(
                                                  comment.id, comment.image)
                                              .then((success) {
                                            if (success) {
                                              cComment.setComments(topic);
                                            }
                                          });
                                        },
                                        child: const Row(
                                          children: [
                                            Icon(Icons.delete, size: 13),
                                            Text(
                                              'Delete',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Material(
              color: AppColor.primary,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<CComment>(
                      builder: (contextConsumer, _, child) {
                        if (_.replyTo == null) return DView.nothing();
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                          child: Row(
                            children: [
                              const Text(
                                'To: ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                _.replyTo!.username,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    Consumer<CComment>(
                      builder: (contextConsumer, _, child) {
                        if (_.image == '') return DView.nothing();
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                          child: Text(
                            'Image: ${_.image}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () =>
                              cComment.pickImage(ImageSource.gallery),
                          icon: const Icon(Icons.image, color: Colors.white),
                        ),
                        IconButton(
                          padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                          onPressed: () =>
                              cComment.pickImage(ImageSource.camera),
                          icon: const Icon(Icons.photo_camera,
                              color: Colors.white),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              controller: controllerInput,
                              minLines: 1,
                              maxLines: 5,
                              decoration: const InputDecoration(
                                hintText: 'Comment...',
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsetsDirectional.symmetric(
                                  horizontal: 8,
                                  vertical: 12,
                                ),
                              ),
                              style: const TextStyle(height: 1, fontSize: 14),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            CommentSource.create(
                              topic.id,
                              cUser.data!.id,
                              context.read<CComment>().replyTo!.id,
                              controllerInput.text,
                              context.read<CComment>().image,
                              context.read<CComment>().imageBase64code,
                            ).then((success) {
                              if (success) {
                                controllerInput.clear();
                                cComment.setComments(topic);
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
