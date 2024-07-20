import 'package:hive/hive.dart';
import 'package:shoe_plug/models/product.dart';

const favouriteKey = "favourites";
const ordersKey = "orders";

class StorageService {
  StorageService._();
  static StorageService instance = StorageService._();
  final box = Hive.box<List>("shoePlug");

  List<Product> getFavourites() {
    final favourites =
        box.get(favouriteKey, defaultValue: [])?.cast<Product>() ?? [];

    return favourites;
  }

  void addToFavourites(Product product) {
    final favourites = box.get(favouriteKey);
    if (favourites == null) {
      box.put(favouriteKey, [product]);
      return;
    }
    favourites.add(product);
    box.put(favouriteKey, favourites);
  }

  void removeFromWishlist(Product product) {
    final favourites = box.get(favouriteKey);
    favourites?.removeWhere((element) => element.id == product.id);
  }

  void saveOrder(List<Product> order) {
    final existingOrders =
        box.get(ordersKey, defaultValue: [])?.cast<List<Product>>() ?? [];
    existingOrders.add(order);
    box.put(ordersKey, existingOrders);
  }

  List<List<Product>> getOrders() {
    final existingOrders =
        box.get(ordersKey, defaultValue: [])?.cast<List<Product>>() ?? [];

    return existingOrders;
  }
}
