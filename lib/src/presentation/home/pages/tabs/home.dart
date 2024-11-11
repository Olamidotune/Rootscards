import 'package:flutter/material.dart';
import 'package:rootscards/src/presentation/home/pages/dashboard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dashboard',
        
      ),
      body: Center(
        child: Text('Hello, HomeScreen!'),
      ),
    );
  }
}
