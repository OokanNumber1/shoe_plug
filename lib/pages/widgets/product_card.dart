import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_plug/core/assets.dart';
import 'package:shoe_plug/core/colors.dart';
import 'package:shoe_plug/core/spacing.dart';
import 'package:shoe_plug/core/style.dart';
import 'package:shoe_plug/models/product.dart';
import 'package:shoe_plug/notifier/cart_notifier.dart';
import 'package:shoe_plug/notifier/wishlist_notifier.dart';
import 'package:shoe_plug/pages/details.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    required this.product,
    this.isSpecialOffer = true,
    required this.onFavouriteAction,
    super.key,
  });
  final Product product;
  final bool isSpecialOffer;
  final VoidCallback onFavouriteAction;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    final cartNotifier = CartNotifier.instance;
    final wishlistNotifier = WishlistNotifier.instance;

    final isFavourited = wishlistNotifier.wishlists
        .where((element) => element.id == product.id)
        .isNotEmpty;

    final isCarted = cartNotifier.productsInCart
        .where((element) => element.id == widget.product.id)
        .isNotEmpty;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            product: widget.product,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: product.id,
            child: Container(
              height: 180,
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(widget.product.image),
                ),
              ),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    widget.onFavouriteAction();
                    setState(() {});
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(
                      isFavourited ? Icons.favorite : Icons.favorite_border,
                      color: isFavourited ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ySpacing(4),
          Text(
            widget.product.category,
            style: styleWith(size: 10),
          ),
          ySpacing(2),
          Text(
            widget.product.name,
            style: styleWith(
              size: 12,
              weight: FontWeight.w600,
            ),
          ),
          ySpacing(4),
          Row(
            children: [
              const Icon(
                Icons.star_half,
                size: 12,
                color: AppColors.lightYellow,
              ),
              xSpacing(2),
              Text(
                "4.5 (100 sold)",
                style: styleWith(
                  size: 10,
                  weight: FontWeight.w500,
                ),
              )
            ],
          ),
          ySpacing(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "₦ ${widget.product.amount}",
                    style: styleWith(
                        size: 12,
                        weight: FontWeight.w600,
                        color: AppColors.blue),
                  ),
                  ySpacing(2),
                  widget.isSpecialOffer
                      ? Text(
                          "₦ 21,000.00",
                          style: styleWith(
                            size: 12,
                            weight: FontWeight.w500,
                            color: AppColors.gray200,
                          ).copyWith(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: AppColors.gray200,
                          ),
                        )
                      : const SizedBox()
                ],
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
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.7),
      highlightColor: Colors.white,
      child: Container(
        height: 180,
        decoration: ShapeDecoration(
          color: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
