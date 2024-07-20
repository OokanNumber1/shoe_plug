import 'package:flutter/material.dart';
import 'package:shoe_plug/models/product.dart';
import 'package:shoe_plug/service/storage_service.dart';

class WishlistNotifier extends ChangeNotifier {
  WishlistNotifier._();
  static WishlistNotifier instance = WishlistNotifier._();

  List<Product> _wishlists = [];
  List<Product> get wishlists => _wishlists;

  final storage = StorageService.instance;

  void addToWishlist(Product product) {
    _wishlists.contains(product)?removeFavourite(product):
    storage.addToFavourites(product);
    getWishlists();
  }

  void getWishlists() {
    _wishlists = storage.getFavourites();
    
    notifyListeners();
  }

  void removeFavourite(Product product) {
    storage.removeFromWishlist(product);
    
    getWishlists();
    notifyListeners();
  }
}
