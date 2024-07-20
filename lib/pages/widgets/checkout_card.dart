import 'package:flutter/material.dart';
import 'package:shoe_plug/core/colors.dart';
import 'package:shoe_plug/core/spacing.dart';
import 'package:shoe_plug/core/style.dart';
import 'package:shoe_plug/models/product.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    required this.product,
    required this.onCountChanged,
    required this.onRemoved,
    super.key,
  });
  final Product product;
  final VoidCallback onRemoved;
  final Function(int) onCountChanged;
  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  int numberOfPairs = 1;

  @override
  Widget build(BuildContext context) {

    final product = widget.product;
    
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        color: AppColors.secondary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                product.image,
                width: 80,
              ),
            ),
            xSpacing(12),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: styleWith(
                          size: 15,
                          weight: FontWeight.w500,
                        ),
                      ), //Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: widget.onRemoved,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.close,
                              color: AppColors.gray500,
                            ),
                          ),
                        ),
                      )
                    ]),
                ySpacing(10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              if (numberOfPairs > 1) {
                                setState(() {
                                  numberOfPairs -= 1;
                                  widget.onCountChanged(
                                    numberOfPairs,
                                  );
                                });
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              child: Icon(Icons.remove),
                            ),
                          ),
                          xSpacing(4),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.cardColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(numberOfPairs.toString()),
                          ),
                          xSpacing(4),
                          InkWell(
                            onTap: () {
                              setState(() {
                                numberOfPairs += 1;
                                widget.onCountChanged(numberOfPairs);
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    ),
                    xSpacing(12),
                    Text("₦ ${numberOfPairs * product.amount}")
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
