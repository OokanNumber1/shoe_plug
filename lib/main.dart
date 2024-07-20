import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoe_plug/models/product.dart';
import 'package:shoe_plug/pages/dashboard.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<List>("shoePlug");
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
      ),
      home: const DashboardPage(),
    );
  }
}
