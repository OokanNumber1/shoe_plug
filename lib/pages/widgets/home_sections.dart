import 'package:flutter/material.dart';
import 'package:shoe_plug/core/spacing.dart';
import 'package:shoe_plug/core/style.dart';
import 'package:shoe_plug/models/product.dart';
import 'package:shoe_plug/notifier/wishlist_notifier.dart';
import 'package:shoe_plug/pages/widgets/product_card.dart';

class SpecialOfferSection extends StatefulWidget {
  const SpecialOfferSection({
    required this.offers,
    required this.isLoading,
    super.key,
  });
  final List<Product> offers;
  final bool isLoading;
  @override
  State<SpecialOfferSection> createState() => _SpecialOfferSectionState();
}

class _SpecialOfferSectionState extends State<SpecialOfferSection> {
  @override
  Widget build(BuildContext context) {
    final wishlistNotifier = WishlistNotifier.instance;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Our Special Offers",
          style: styleWith(
            size: 24,
            weight: FontWeight.w500,
          ),
        ),
        ySpacing(20),
        Expanded(
          child: GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 12,
              childAspectRatio: 0.52,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
            ),
            children: List.generate(widget.offers.length, (index) {
              final product = widget.offers[index];
              final isFavourited = wishlistNotifier.wishlists
                  .where(
                    (element) => element.id == product.id,
                  )
                  .isNotEmpty;
              return widget.isLoading
                  ? const ShimmerLoading()
                  : ProductCard(
                      onFavouriteAction: () {
                        isFavourited
                            ? wishlistNotifier.removeFavourite(product)
                            : wishlistNotifier.addToWishlist(product);
                      },
                      product: widget.offers[index],
                    );
            }),
          ),
        )
      ],
    );
  }
}

class FeaturedSection extends StatefulWidget {
  const FeaturedSection(
      {required this.isLoading, required this.offers, super.key});
  final List<Product> offers;
  final bool isLoading;
  @override
  State<FeaturedSection> createState() => _FeaturedSectionState();
}

class _FeaturedSectionState extends State<FeaturedSection> {
  @override
  Widget build(BuildContext context) {
    final wishlistNotifier = WishlistNotifier.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Featured Sneakers",
          style: styleWith(size: 24, weight: FontWeight.w500),
        ),
        ySpacing(20),
        Expanded(
          child: GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.52,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
            ),

            children: List.generate(widget.offers.length, (index) {
              final product = widget.offers[index];
              final isFavourited = wishlistNotifier.wishlists
                  .where((element) => element.id == product.id)
                  .isNotEmpty;
              return widget.isLoading
                  ? const ShimmerLoading()
                  : ProductCard(
                      onFavouriteAction: () {
                        isFavourited
                            ? wishlistNotifier.removeFavourite(product)
                            : wishlistNotifier.addToWishlist(product);
                      },
                      product: widget.offers[index],
                    );
            }),
          ),
        )
      ],
    );
  }
}
