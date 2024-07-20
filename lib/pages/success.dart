import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_plug/core/assets.dart';
import 'package:shoe_plug/core/colors.dart';
import 'package:shoe_plug/core/spacing.dart';
import 'package:shoe_plug/core/style.dart';
import 'package:shoe_plug/notifier/cart_notifier.dart';
import 'package:shoe_plug/pages/dashboard.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CartNotifier.instance;
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.check),
              ySpacing(8),
              Text(
                "Payment successful",
                style: styleWith(
                  size: 20,
                  weight: FontWeight.w500,
                ),
              ),
              ySpacing(8),
              const Text(
                "You have successfully placed an order. Details of your order has been sent to your email.",
                textAlign: TextAlign.center,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children:
                    List.generate(cartNotifier.productsInCart.length, (index) {
                  final product = cartNotifier.productsInCart[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${product.name} "),
                            Text("\$${product.amount}")
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Divider()
                      ],
                    ),
                  );
                }),
              ),
              ySpacing(32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    fixedSize: const Size(double.maxFinite, 42)),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardPage()),
                  );
                },
                child: Text(
                  "Okay",
                  style: styleWith(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
