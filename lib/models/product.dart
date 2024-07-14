class Product {
  const Product({
    required this.amount,
    required this.image,
    required this.name,
    required this.description,
    required this.section,
    required this.id,
  });
  final String image, name, section;
  final num amount;
  final String description, id;

  Product copyWith(num? amount) {
    return Product(
      amount: amount ?? this.amount,
      image: image,
      name: name,
      description: description,
      section: section,
      id: id,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    const imageBasePath = "https://api.timbu.cloud/images";
    final imageJson = (json["photos"] as List<dynamic>).first;
    final priceJson = (json["current_price"] as List<dynamic>).first;
    return Product(
      section: "",
      id: json["id"],
      amount: priceJson["NGN"].first,
      image: "$imageBasePath/${imageJson["url"]}",
      name: json["name"],
      description: json["description"],
    );
  }

  static Product empty() => const Product(
      amount: 0, image: "", name: "", description: "", id: "", section: "");
}
