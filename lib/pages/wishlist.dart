import 'package:flutter/material.dart';
import 'package:shoe_plug/notifier/wishlist_notifier.dart';
import 'package:shoe_plug/pages/widgets/empty_state_widget.dart';
import 'package:shoe_plug/pages/widgets/product_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    WishlistNotifier.instance.getWishlists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final wishlist = WishlistNotifier.instance.wishlists;
    final wishlistNotifier = WishlistNotifier.instance;
    final wishlistIsEmpty = wishlist.isEmpty;

    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
      ),
      body: wishlistIsEmpty
          ? const Center(child: EmptyStateWidget(label: "No favourite yet"))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: screenHeight * 00.88,
                child: GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.5,
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                  ),
                  children: List.generate(
                    wishlist.length,
                    (index) => ProductCard(
                      onFavouriteAction: () {
                        wishlistNotifier.removeFavourite(wishlist[index]);
                        setState(() {});
                      },
                      product: wishlist[index],
                    ),
                  ),
                ),
              )),
    );
  }
}
