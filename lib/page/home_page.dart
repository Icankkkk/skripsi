import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  logout() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarCenter('Home'),
      body: Center(
        child: ElevatedButton(
          onPressed: () => logout(),
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
