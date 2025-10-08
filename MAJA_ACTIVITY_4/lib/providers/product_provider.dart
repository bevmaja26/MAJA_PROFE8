import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    // Sample products
    Product(
      id: '1',
      name: 'Mathematics Textbook Grade 10',
      description: 'Comprehensive mathematics textbook for grade 10 students',
      price: 25.99,
      category: ProductCategory.books,
      stockQuantity: 50,
      imageUrl: null,
    ),
    Product(
      id: '2',
      name: 'School Uniform Set',
      description: 'Complete school uniform including shirt, pants, and tie',
      price: 45.00,
      category: ProductCategory.uniforms,
      stockQuantity: 30,
      imageUrl: null,
    ),
    Product(
      id: '3',
      name: 'Spiral Notebook Pack (5)',
      description: 'Pack of 5 spiral notebooks, 100 pages each',
      price: 12.50,
      category: ProductCategory.notebooks,
      stockQuantity: 100,
      imageUrl: null,
    ),
    Product(
      id: '4',
      name: 'Geometry Set',
      description: 'Complete geometry set with compass, protractor, and rulers',
      price: 8.99,
      category: ProductCategory.stationery,
      stockQuantity: 75,
      imageUrl: null,
    ),
    Product(
      id: '5',
      name: 'School Backpack',
      description: 'Durable backpack with multiple compartments',
      price: 35.00,
      category: ProductCategory.bags,
      stockQuantity: 40,
      imageUrl: null,
    ),
    Product(
      id: '6',
      name: 'Art Supplies Kit',
      description: 'Complete art kit with paints, brushes, and canvas',
      price: 28.50,
      category: ProductCategory.artSupplies,
      stockQuantity: 25,
      imageUrl: null,
    ),
    Product(
      id: '7',
      name: 'Scientific Calculator',
      description: 'Advanced scientific calculator for mathematics and science',
      price: 22.00,
      category: ProductCategory.electronics,
      stockQuantity: 60,
      imageUrl: null,
    ),
    Product(
      id: '8',
      name: 'Pen Set (12 pieces)',
      description: 'Set of 12 ballpoint pens in assorted colors',
      price: 5.99,
      category: ProductCategory.stationery,
      stockQuantity: 150,
      imageUrl: null,
    ),
  ];

  List<Product> get products => _products;

  List<Product> getProductsByCategory(ProductCategory category) {
    return _products.where((p) => p.category == category).toList();
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Product> searchProducts(String query) {
    final lowerQuery = query.toLowerCase();
    return _products.where((p) {
      return p.name.toLowerCase().contains(lowerQuery) ||
          p.description.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _products[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
