import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_plug/core/assets.dart';
import 'package:shoe_plug/core/colors.dart';
import 'package:shoe_plug/core/spacing.dart';
import 'package:shoe_plug/core/style.dart';
import 'package:shoe_plug/notifier/cart_notifier.dart';

class ProductPreviewCard extends StatefulWidget {
  const ProductPreviewCard({super.key});

  @override
  State<ProductPreviewCard> createState() => _ProductPreviewCardState();
}

class _ProductPreviewCardState extends State<ProductPreviewCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    final cartNotifier = CartNotifier.instance;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 32,
      ),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0072C6),
            Color(0xFF003760),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidth * 0.4,
            height: 120,
            child: Image.network(
              cartNotifier.timbuResponse.products?.first.image ?? "",
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Iconic Casual Brands",
                style: styleWith(size: 8, color: AppColors.gray50),
              ),
              Text(
                "${cartNotifier.timbuResponse.products?.first.name ?? ""} ₦ ${cartNotifier.timbuResponse.products?.first.amount ?? ""}",
                style: styleWith(
                  size: 12,
                  color: Colors.white,
                  weight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    cartNotifier.addToCart(
                      cartNotifier.timbuResponse.products!.first,
                    );
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(30),
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.cart),
                      xSpacing(8),
                      Text(
                        cartNotifier.productsInCart
                                .where((element) =>
                                    element.id ==
                                    cartNotifier
                                        .timbuResponse.products!.first.id)
                                .isNotEmpty
                            ? "Remove from cart"
                            : "Add to cart",
                        style: styleWith(
                          color: AppColors.blue,
                          size: 12,
                          weight: FontWeight.w500,
                        ),
                      )
                    ],
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
