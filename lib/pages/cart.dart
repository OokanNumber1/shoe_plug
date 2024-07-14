import 'package:flutter/material.dart';
import 'package:shoe_plug/notifier/cart_notifier.dart';
import 'package:shoe_plug/pages/success.dart';
import 'package:shoe_plug/pages/widgets/checkout_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
     final cartNotifier = CartNotifier.instance;
    final cartIsEmpty = cartNotifier.productsInCart.isEmpty;
    return Scaffold(
      appBar: AppBar(
        
        title: const Text("My Cart",
            style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w400,
                fontSize: 24)),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: cartIsEmpty
            ? const Center(
                child: Text("Cart is currently empty"),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.64,
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        cartNotifier.productsInCart.length,
                        
                        (index) => CheckoutCard(
                          onCountChanged: (value) {
                            cartNotifier.setNumberInCart(index: index, value: value);
                            setState(() {
                              
                            });
                          },
                          onRemoved: () {
                            cartNotifier.removeFromCart(
                              cartNotifier.productsInCart[index],
                            );

                            setState(() {});
                          },
                          product: cartNotifier.productsInCart[index],
                        ),
                      ),
                    )),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Text(
                        "Total Price",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        "\$${cartNotifier.getTotalAmountInCart()}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SuccessPage(),
                          ));
                    },
                    child: const Text("Purchase"),
                  )
                ],
              ),
      )),
    );
  }
}