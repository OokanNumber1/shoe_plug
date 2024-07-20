import 'package:flutter/material.dart';
import 'package:shoe_plug/models/product.dart';
import 'package:shoe_plug/models/timbu_response.dart';
import 'package:shoe_plug/service/http_service.dart';

class CartNotifier extends ChangeNotifier {
  CartNotifier._();

  static final instance = CartNotifier._();

  bool isLoading = false;

  TimbuResponse timbuResponse = TimbuResponse();
  List<Product> productsFromTimbu = [];

  Set<Product> _productsInCart = {};
  Map<int, int> numberInCart = {};
  List<Product> get productsInCart => _productsInCart.toList();

  Future<TimbuResponse> getProductsFromTimbu() async {
    final client = HttpService();

    try {
      timbuResponse.isLoading = true;
      notifyListeners();
      final response = await client.getProducts();
      timbuResponse.products = response;
      timbuResponse.isLoading = false;
      // notifyListeners();
      timbuResponse.errorMessage = null;
      notifyListeners();

      return timbuResponse;
    } catch (e) {
      timbuResponse.errorMessage = e.toString();
      timbuResponse.isLoading = false;
      timbuResponse.products = null;
      notifyListeners();
      return timbuResponse;
    }
  }

  void addToCart(Product product) {
    _productsInCart.contains(product)
        ? removeFromCart(product)
        : _productsInCart.add(product);

    notifyListeners();
  }

  void removeFromCart(Product product) {
    _productsInCart.remove(product);
    notifyListeners();
  }

  void invalidateCart() {
    _productsInCart = {};
    notifyListeners();
  }

  void setNumberInCart({
    required int index,
    required int value,
  }) {
    numberInCart[index] = value;
    notifyListeners();
  }

  List<Product> categoriseProduct(String brandName) {
    final products = timbuResponse.products ?? [];
    if (products.isEmpty) {
      return [];
    }
    return products
        .where((product) => product.category == brandName.toLowerCase())
        .toList();
  }

  num getTotalAmountInCart() {
    if (_productsInCart.isEmpty) {
      return 0;
    }
    num total = 0;
    final productList = _productsInCart.toList();

    for (int index = 0; index < productList.length; index++) {
      final numberOfPairs = numberInCart[index] ?? 1;
      total += (productList[index].amount * numberOfPairs);
    }
    return total;
  }
}
