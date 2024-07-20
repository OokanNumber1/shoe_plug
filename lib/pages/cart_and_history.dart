import 'package:flutter/material.dart';
import 'package:shoe_plug/core/colors.dart';
import 'package:shoe_plug/notifier/cart_notifier.dart';
import 'package:shoe_plug/notifier/orders_notifier.dart';
import 'package:shoe_plug/pages/orders_history.dart';
import 'package:shoe_plug/pages/widgets/checkout_card.dart';
import 'package:shoe_plug/pages/widgets/checkout_sheet.dart';
import 'package:shoe_plug/pages/widgets/empty_state_widget.dart';

class CartAndHistoryPage extends StatefulWidget {
  const CartAndHistoryPage({super.key});

  @override
  State<CartAndHistoryPage> createState() => _CartAndHistoryPageState();
}

class _CartAndHistoryPageState extends State<CartAndHistoryPage> {
  @override
  void initState() {
    OrdersNotifier.instance.getOrdersHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            "Orders",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 24,
            ),
          ),
          bottom: const TabBar(tabs: [
            Tab(text: "Carts"),
            Tab(text: "Order history"),
          ]),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            child: TabBarView(
              children: [
                OngoingOrders(),
                OrdersHistoryPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OngoingOrders extends StatefulWidget {
  const OngoingOrders({super.key});

  @override
  State<OngoingOrders> createState() => _OngoingOrdersState();
}

class _OngoingOrdersState extends State<OngoingOrders> {
  @override
  Widget build(BuildContext context) {
    final cartNotifier = CartNotifier.instance;
    final cartIsEmpty = cartNotifier.productsInCart.isEmpty;

    return cartIsEmpty
        ? const EmptyStateWidget(label: "Nothing in the cart yet")
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.6,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      cartNotifier.productsInCart.length,
                      (index) => CheckoutCard(
                        onCountChanged: (value) {
                          cartNotifier.setNumberInCart(
                            index: index,
                            value: value,
                          );
                          setState(() {});
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
                  ),
                ),
              ),
              // const Spacer(),
              Row(
                children: [
                  const Text(
                    "Total Price",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "\$${cartNotifier.getTotalAmountInCart()}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12),
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
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return DepositBottomSheet(
                        amountToPay: cartNotifier.getTotalAmountInCart(),
                      );
                    },
                  );
                },
                child: const Text("Purchase"),
              )
            ],
          );
  }
}
