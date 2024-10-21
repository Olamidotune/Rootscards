import 'package:flutter/material.dart';

class LinkScreen extends StatelessWidget {
  const LinkScreen({super.key});

    static const String routeName = 'LinkScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Link Screen'),
      ),
      body: Center(
        child: Text('Hello, Link!'),
      ),
    );
  }
}