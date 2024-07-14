import 'package:flutter/material.dart';
import 'package:shoe_plug/pages/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoe Plug',
      theme: ThemeData(
        fontFamily: "Roboto Flex",
       
        // useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}
