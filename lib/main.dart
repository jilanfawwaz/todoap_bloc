import 'package:flutter/material.dart';
import 'package:todoapp_bloc/pages/homepages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePages(),
      debugShowCheckedModeBanner: false,
    );
  }
}
