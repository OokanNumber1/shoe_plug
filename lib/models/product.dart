import 'package:hive/hive.dart';

class Product {
  const Product({
    required this.amount,
    required this.image,
    required this.name,
    required this.description,
    required this.id,
    required this.category,
  });
  final String image, name, category;
  final num amount;
  final String description, id;

  Product copyWith(num? amount) {
    return Product(
      category: category,
      amount: amount ?? this.amount,
      image: image,
      name: name,
      description: description,
      id: id,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    const imageBasePath = "https://api.timbu.cloud/images";
    final imageJson = (json["photos"] as List<dynamic>).first;
    final priceJson = (json["current_price"] as List<dynamic>).first;
    final serialisedCategory = (json["categories"] as List).isNotEmpty
        ? json["categories"].first["name"]
        : "";
    return Product(
      category: serialisedCategory,
      id: json["id"],
      amount: priceJson["NGN"].first,
      image: "$imageBasePath/${imageJson["url"]}",
      name: json["name"],
      description: json["description"],
    );
  }

  factory Product.fromLocalMap(Map<dynamic, dynamic> json) {
    return Product(
      category: json["category"],
      id: json["id"] ?? "",
      amount: json["amount"] ?? 1,
      image: json["iimage"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "amount": amount,
      "name": name,
      "image": image,
      "description": description,
    };
  }

  static Product empty() => const Product(
      amount: 0, image: "", name: "", description: "", id: "", category: "");
}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  Product read(BinaryReader reader) {
    return Product(
      amount: reader.read(),
      image: reader.read(),
      name: reader.read(),
      description: reader.read(),
      category: reader.read(),
      id: reader.read(),
    );
  }

  @override
  int get typeId => 00;

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.write(obj.amount);
    writer.write(obj.image);
    writer.write(obj.name);
    writer.write(obj.description);
    writer.write(obj.category);
    writer.write(obj.id);
  }
}
