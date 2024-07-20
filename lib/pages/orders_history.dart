import 'package:flutter/material.dart';
import 'package:shoe_plug/core/spacing.dart';
import 'package:shoe_plug/models/product.dart';
import 'package:shoe_plug/notifier/orders_notifier.dart';
import 'package:shoe_plug/pages/widgets/empty_state_widget.dart';

class OrdersHistoryPage extends StatelessWidget {
  const OrdersHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersNotifier = OrdersNotifier.instance;
    final historyIsEmpty = ordersNotifier.orders.isEmpty;
    return  historyIsEmpty? const EmptyStateWidget(label: "No history yet")
        : SingleChildScrollView(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(ordersNotifier.orders.length, (index) {
              final order = ordersNotifier.orders;
          
              return  OrderHistoryCard(order: order[index],
            
              );
            }),
          ],
                ),
        );
    
  }
}

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({
    required this.order,
    super.key,
  });
  final List<Product> order;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
       const   Text("Completed"),
          ...List.generate(
            order.length,
            (index) {
              final product = order[index];
              return Row(
                children: [
                  Image.network(
                    product.image,
                    height: 120,
                    width: 80,
                  ),
                  xSpacing(12),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name),
                      ySpacing(8),
                      Text("₦ ${product.amount}")
                    ],
                  ),
                ],
              );
            },
          )
        ]),
      )),
    );
  }
}
