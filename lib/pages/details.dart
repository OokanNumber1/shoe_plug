import 'package:flutter/material.dart';
import 'package:shoe_plug/core/colors.dart';
import 'package:shoe_plug/core/spacing.dart';
import 'package:shoe_plug/core/style.dart';
import 'package:shoe_plug/models/product.dart';

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
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.cardColor,),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 320,
              width: screenWidth,
              decoration: const BoxDecoration(color: AppColors.cardColor),
              child: Image.network(product.image),
            ),
            ySpacing(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.section,
                    style: styleWith(size: 12),
                  ),
                  ySpacing(2),
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
                  ),ySpacing(12),
                  Text("Description",style: styleWith(
                      size: 15,
                      weight: FontWeight.w500,
                    ),),
                  Text(product.description),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
