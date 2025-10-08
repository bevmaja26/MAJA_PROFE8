enum ProductCategory {
  books,
  uniforms,
  notebooks,
  stationery,
  bags,
  artSupplies,
  electronics,
  other
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final ProductCategory category;
  final int stockQuantity;
  final String? imageUrl;
  final bool isAvailable;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.stockQuantity,
    this.imageUrl,
    this.isAvailable = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category.toString(),
      'stockQuantity': stockQuantity,
      'imageUrl': imageUrl,
      'isAvailable': isAvailable,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: ProductCategory.values.firstWhere(
        (e) => e.toString() == json['category'],
        orElse: () => ProductCategory.other,
      ),
      stockQuantity: json['stockQuantity'],
      imageUrl: json['imageUrl'],
      isAvailable: json['isAvailable'] ?? true,
    );
  }
}
