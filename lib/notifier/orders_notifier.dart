import 'package:flutter/material.dart';
import 'package:shoe_plug/models/product.dart';
import 'package:shoe_plug/service/storage_service.dart';

class OrdersNotifier extends ChangeNotifier {
   OrdersNotifier._();
   static final instance = OrdersNotifier._();

  List<List<Product>> _orders = [];
  List<List<Product>> get orders => _orders;
  
  final storage = StorageService.instance;
  
  void getOrdersHistory() {
   _orders = storage.getOrders();
    notifyListeners();
  }

  void saveOrderHistory(List<Product> order){
    storage.saveOrder(order);
    
  }
}
