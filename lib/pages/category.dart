import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_plug/core/assets.dart';
import 'package:shoe_plug/core/colors.dart';
import 'package:shoe_plug/core/spacing.dart';
import 'package:shoe_plug/core/style.dart';
import 'package:shoe_plug/models/product.dart';
import 'package:shoe_plug/notifier/cart_notifier.dart';
import 'package:shoe_plug/notifier/wishlist_notifier.dart';
import 'package:shoe_plug/pages/widgets/empty_state_widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    required this.products,
    required this.brand,
    super.key,
  });
  final List<Product> products;
  final String brand;
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final products = widget.products;
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.brand} Products"),
      ),
      body: products.isEmpty
          ? EmptyStateWidget(
              label: "${widget.brand} products are not available yet!.",
            )
          : ListView(
              children: List.generate(
                products.length,
                (index) => CategoryCard(product: products[index]),
              ),
            ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    required this.product,
    super.key,
  });
  final Product product;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final cartNotifier = CartNotifier.instance;
    final wishlistNotifier = WishlistNotifier.instance;

    final isWishlisted = wishlistNotifier.wishlists
        .where((element) => element.id == widget.product.id)
        .isNotEmpty;

    final isCarted = cartNotifier.productsInCart
        .where(
          (element) => element.id == widget.product.id,
        )
        .isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12.0,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenWidth * 0.2,
                child: Image.network(widget.product.image),
              ),
              xSpacing(8),
              SizedBox(
                width: screenWidth * 0.42,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.product.name,
                      style: styleWith(
                        size: 18,
                        weight: FontWeight.w600,
                      ),
                    ),
                    ySpacing(6),
                    Text(
                      widget.product.description,
                      style: styleWith(size: 14),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      isWishlisted
                          ? wishlistNotifier.removeFavourite(widget.product)
                          : wishlistNotifier.addToWishlist(widget.product);
                      setState(() {});
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.gray200,
                      child: Icon(
                        isWishlisted ? Icons.favorite : Icons.favorite_border,
                        color: isWishlisted ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cartNotifier.addToCart(widget.product);
                      setState(() {});
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blue.withAlpha(12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: isCarted
                            ? const Icon(
                                Icons.shopping_basket,
                                color: AppColors.blue,
                                size: 16,
                              )
                            : SvgPicture.asset(AppIcons.cart),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
