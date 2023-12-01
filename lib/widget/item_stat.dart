import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

import '../config/app_format.dart';

class ItemStat extends StatelessWidget {
  const ItemStat({super.key, required this.title, required this.value});
  final String title;
  final num value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        DView.spaceWidth(4),
        DView.textTitle(AppFormat.infoNumber(value.toDouble())),
      ],
    );
  }
}
