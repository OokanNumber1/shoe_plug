import 'package:flutter/material.dart';
import 'package:shoe_plug/core/colors.dart';
import 'package:shoe_plug/core/spacing.dart';
import 'package:shoe_plug/core/style.dart';
import 'package:shoe_plug/models/product.dart';
import 'package:shoe_plug/notifier/cart_notifier.dart';
import 'package:shoe_plug/notifier/wishlist_notifier.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    required this.product,
    super.key,
  });
  final Product product;
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {

    final product = widget.product;
    final cartNotifier = CartNotifier.instance;
    final wishlistNotifier = WishlistNotifier.instance;

    final isCarted = cartNotifier.productsInCart
        .where((element) => element.id == widget.product.id)
        .isNotEmpty;
    
    final isWishlisted = wishlistNotifier.wishlists
        .where((element) => element.id == product.id)
        .isNotEmpty;
    
    final screenWidth = MediaQuery.sizeOf(context).width;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 320,
              width: screenWidth,
              decoration: const BoxDecoration(color: AppColors.cardColor,),
              child: Hero(
                tag: product.id,
                child: Image.network(product.image)),
            ),
            ySpacing(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category,
                    style: styleWith(size: 12),
                  ),
                  ySpacing(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: styleWith(
                              size: 24,
                              weight: FontWeight.w600,
                            ),
                          ),
                          ySpacing(4),
                          Text(
                            "₦ ${product.amount}",
                            style: styleWith(
                              size: 15,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          isWishlisted
                              ? wishlistNotifier.removeFavourite(product)
                              : wishlistNotifier.addToWishlist(product);
                          setState(() {});
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor:  Colors.grey.shade300,
                            child: Icon(
                              isWishlisted
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isWishlisted ? Colors.red : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ySpacing(12),
                  Text(
                    "Description",
                    style: styleWith(
                      size: 15,
                      weight: FontWeight.w500,
                    ),
                  ),
                  Text(product.description),
                  ySpacing(64),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 44),
                      backgroundColor: AppColors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      cartNotifier.addToCart(product);
                      setState(() {});
                    },
                    child: Text(isCarted ? "Remove from cart" : "Add to cart"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
