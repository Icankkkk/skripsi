import 'package:flutter/material.dart';

class ItemDivider extends StatelessWidget {
  const ItemDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 30,
      width: 0.5,
    );
  }
}
