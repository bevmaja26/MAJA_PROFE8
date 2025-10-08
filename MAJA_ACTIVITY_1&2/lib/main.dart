import 'package:flutter/material.dart';
import 'views/home_screen.dart';

void main() {
  runApp(BeverlysEventApp());
}

class BeverlysEventApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beverly\'s Event Creations',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
