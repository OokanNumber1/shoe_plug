import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_plug/core/assets.dart';
import 'package:shoe_plug/pages/cart.dart';
import 'package:shoe_plug/pages/home.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedPageIndex = 0;
  final pages = const[HomePage(),CartPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      body: pages[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPageIndex,
        onTap: (value) => setState(() {
          selectedPageIndex=value;
        }),
        items: [
     const    BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home"
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppIcons.cart),
          label: "Cart"
        ),
      ]),
    );
  }
}
