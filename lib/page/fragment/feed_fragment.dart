import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class FeedFragment extends StatelessWidget {
  const FeedFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: DView.textTitle('Feed', size: 80)),
    );
  }
}
