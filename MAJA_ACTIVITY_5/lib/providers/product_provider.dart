import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Scientific Calculator',
      description:
          'Advanced scientific calculator for mathematics and engineering students',
      price: 29.99,
      category: 'Electronics',
      imageUrl:
          'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=400',
      stock: 50,
      tags: ['calculator', 'math', 'science'],
      rating: 4.5,
      reviewCount: 128,
    ),
    Product(
      id: '2',
      name: 'Notebook Set (5 Pack)',
      description: 'Premium quality notebooks with 200 pages each',
      price: 15.99,
      category: 'Stationery',
      imageUrl:
          'https://images.unsplash.com/photo-1517842645767-c639042777db?w=400',
      stock: 200,
      tags: ['notebook', 'writing', 'paper'],
      rating: 4.8,
      reviewCount: 256,
    ),
    Product(
      id: '3',
      name: 'Art Supplies Kit',
      description: 'Complete art supplies kit with colors, brushes, and canvas',
      price: 45.99,
      category: 'Art',
      imageUrl:
          'https://images.unsplash.com/photo-1513364776144-60967b0f800f?w=400',
      stock: 30,
      tags: ['art', 'painting', 'creative'],
      rating: 4.7,
      reviewCount: 89,
    ),
    Product(
      id: '4',
      name: 'Backpack - Student Edition',
      description:
          'Durable backpack with laptop compartment and multiple pockets',
      price: 39.99,
      category: 'Bags',
      imageUrl:
          'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400',
      stock: 75,
      tags: ['backpack', 'bag', 'storage'],
      rating: 4.6,
      reviewCount: 342,
    ),
    Product(
      id: '5',
      name: 'Geometry Set',
      description:
          'Professional geometry set with compass, protractor, and rulers',
      price: 12.99,
      category: 'Math Tools',
      imageUrl:
          'https://images.unsplash.com/photo-1596495577886-d920f1fb7238?w=400',
      stock: 120,
      tags: ['geometry', 'math', 'tools'],
      rating: 4.4,
      reviewCount: 167,
    ),
  ];

  List<Product> get products => _products;

  List<Product> getProductsByCategory(String category) {
    return _products.where((p) => p.category == category).toList();
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(String id, Product updatedProduct) {
    final index = _products.indexWhere((p) => p.id == id);
    if (index >= 0) {
      _products[index] = updatedProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
