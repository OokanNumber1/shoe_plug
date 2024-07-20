import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoe_plug/core/colors.dart';
import 'package:shoe_plug/core/spacing.dart';
import 'package:shoe_plug/core/style.dart';
import 'package:shoe_plug/notifier/cart_notifier.dart';
import 'package:shoe_plug/notifier/orders_notifier.dart';
import 'package:shoe_plug/pages/success.dart';

class DepositBottomSheet extends StatefulWidget {
  const DepositBottomSheet({
    required this.amountToPay,
    super.key,
  });
  final num amountToPay;
  @override
  State<DepositBottomSheet> createState() => _DepositBottomSheetState();
}

class _DepositBottomSheetState extends State<DepositBottomSheet> {
  final formKey = GlobalKey<FormState>();
  final cardNumberController = TextEditingController();
  final amountController = TextEditingController();
  final cvvController = TextEditingController();
  final expiryDateController = TextEditingController();
  final pinController = TextEditingController();

  bool isPaying = false;
  bool isChecked = false;

  @override
  void dispose() {
    amountController.dispose();
    cardNumberController.dispose();
    cvvController.dispose();
    pinController.dispose();
    expiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                "Pay with card",
                style: styleWith(size: 20),
              ),
              ySpacing(24),
              AppFormField(
                label: "Card number",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field cannot be empty";
                  }
                  return null;
                },
                controller: cardNumberController,
              ),
              ySpacing(20),
              Row(
                children: [
                  Expanded(
                    child: AppFormField(
                      label: "CVV",
                      controller: cvvController,
                    ),
                  ),
                  xSpacing(20),
                  Expanded(
                    child: AppFormField(
                      inputFormatter: const [],
                      label: "Expiry date",
                      keyboardType: TextInputType.name,
                      controller: expiryDateController,
                    ),
                  )
                ],
              ),
              ySpacing(20),
              AppFormField(
                label: "Card PIN",
                controller: pinController,
              ),
              ySpacing(32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    fixedSize: const Size(double.maxFinite, 42)),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    simulatePayment();
                  }
                },
                child: isPaying
                    ? const Center(
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        "Pay",
                        style: styleWith(color: Colors.white),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void simulatePayment() {
    final cartNotifier = CartNotifier.instance;
    final orderNotifier = OrdersNotifier.instance;

    setState(() => isPaying = true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(
        () {
          isPaying = false;
          orderNotifier.saveOrderHistory(
            cartNotifier.productsInCart,
          );
          cartNotifier.invalidateCart();
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SuccessPage(),
              ));
        },
      );
    });
  }
}

class AppFormField extends StatelessWidget {
  const AppFormField({
    required this.label,
    this.validator,
    this.keyboardType,
    this.inputFormatter,
    required this.controller,
    super.key,
  });
  final String label;
  final List<TextInputFormatter>? inputFormatter;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        ySpacing(8),
        TextFormField(
          controller: controller,
          validator: validator ??
              (value) {
                if (value!.isEmpty) {
                  return "Field cannot be empty";
                }
                return null;
              },
          keyboardType: keyboardType ?? TextInputType.number,
          inputFormatters:
              inputFormatter ?? [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
