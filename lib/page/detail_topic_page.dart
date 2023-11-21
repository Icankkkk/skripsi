import 'dart:convert';

import 'package:d_button/d_button.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/api.dart';
import 'package:discuss_app/config/app_format.dart';
import 'package:discuss_app/model/topic.dart';
import 'package:flutter/material.dart';

class DetailTopicPage extends StatelessWidget {
  const DetailTopicPage({super.key, required this.topic});
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    List<String> images = List<String>.from(jsonDecode(topic.images));
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  '${Api.imageUser}/${topic.user!.image}',
                  fit: BoxFit.cover,
                  width: 36,
                  height: 36,
                ),
              ),
            ),
            DView.spaceWidth(),
            Text(
              topic.user!.username,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: DButtonElevation(
          onClick: () {
            // TODO: context.push(AppRoute.comment, extra: topic);
          },
          height: 40,
          mainColor: Theme.of(context).primaryColor,
          child: Row(
            children: [
              const Text('Comments', style: TextStyle(color: Colors.white)),
              DView.spaceWidth(4),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      extendBody: true,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DView.textTitle(topic.title),
          DView.spaceHeight(4),
          Row(
            children: [
              const Icon(
                Icons.event,
                color: Colors.grey,
                size: 15,
              ),
              DView.spaceWidth(4),
              Text(
                AppFormat.fullDateTime(topic.createdAt),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          DView.spaceHeight(),
          Text(topic.description),
          DView.spaceHeight(),
          if (images.isNotEmpty)
            ...images.map((e) {
              return Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (contexDialog) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DView.spaceHeight(),
                            DButtonCircle(
                              diameter: 40,
                              onClick: () => Navigator.pop(contexDialog),
                              child: const Icon(Icons.clear),
                            ),
                            DView.spaceHeight(20),
                            InteractiveViewer(
                              child: Image.network(
                                '${Api.imageTopic}/$e',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        '${Api.imageTopic}/$e',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
        ],
      ),
    );
  }
}
