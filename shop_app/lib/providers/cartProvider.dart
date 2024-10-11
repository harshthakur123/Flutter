import 'package:flutter/material.dart';

class Cartprovider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cart = []; // Use a private variable

  List<Map<String, dynamic>> get cart =>
      List.unmodifiable(_cart); // Read-only cart view

  void addProduct(Map<String, dynamic> product) {
    // Check if the product already exists in the cart
    final existingProduct = _cart.firstWhere(
      (item) => item['id'] == product['id'],
      orElse: () => {'quantity': 0}, // Return a default value instead of null
    );

    if (existingProduct['quantity'] != null &&
        existingProduct['quantity'] > 0) {
      // If it exists, update the quantity
      existingProduct['quantity'] += 1;
    } else {
      // If it does not exist, add it to the cart
      product['quantity'] = 1; // Initialize quantity
      _cart.add(product);
    }

    notifyListeners();
  }

  void removeProduct(Map<String, dynamic> product) {
    // Remove product by ID or other identifier
    _cart.removeWhere((item) => item['id'] == product['id']);
    notifyListeners();
  }

  double get totalAmount {
    return _cart.fold(
        0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  bool get isEmpty => _cart.isEmpty; // Check if the cart is empty
}
