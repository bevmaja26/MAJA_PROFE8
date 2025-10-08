import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const EduSchoolSuppliesApp());
}

class EduSchoolSuppliesApp extends StatelessWidget {
  const EduSchoolSuppliesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edu School Supplies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
