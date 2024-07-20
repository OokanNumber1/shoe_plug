import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_plug/core/assets.dart';
import 'package:shoe_plug/notifier/wishlist_notifier.dart';
import 'package:shoe_plug/pages/cart_and_history.dart';
import 'package:shoe_plug/pages/wishlist.dart';
import 'package:shoe_plug/pages/home.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedPageIndex = 0;
  final pages = const [
    HomePage(),
    CartAndHistoryPage(),
    WishlistPage(),
  ];

  @override
  void initState() {
    WishlistNotifier.instance.getWishlists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedPageIndex,
          onTap: (value) => setState(() {
                selectedPageIndex = value;
              }),
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.cart,
                height: 24,
              ),
              label: "Cart & History",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Wishlist",
            ),
          ]),
    );
  }
}
