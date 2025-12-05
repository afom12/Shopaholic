import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:shop/models/cart_item_model.dart';
import 'package:shop/models/product_model.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  List<CartItemModel> _cartItems = [];
  bool _isLoading = false;

  List<CartItemModel> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount {
    return _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  bool get isEmpty => _cartItems.isEmpty;

  CartProvider() {
    _loadCart();
  }

  Future<void> _loadCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = prefs.getString('cart_items');
      
      if (cartData != null) {
        final List<dynamic> decoded = json.decode(cartData);
        _cartItems = decoded
            .map((item) => CartItemModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading cart: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartData = json.encode(
        _cartItems.map((item) => item.toJson()).toList(),
      );
      await prefs.setString('cart_items', cartData);
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  Future<void> addToCart(
    ProductModel product, {
    int quantity = 1,
    String? selectedSize,
    String? selectedColor,
  }) async {
    // Check if product already exists in cart with same size and color
    final existingIndex = _cartItems.indexWhere(
      (item) =>
          item.product.title == product.title &&
          item.selectedSize == selectedSize &&
          item.selectedColor == selectedColor,
    );

    if (existingIndex != -1) {
      // Update quantity if item exists
      _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
        quantity: _cartItems[existingIndex].quantity + quantity,
      );
    } else {
      // Add new item
      _cartItems.add(
        CartItemModel(
          id: const Uuid().v4(),
          product: product,
          quantity: quantity,
          selectedSize: selectedSize,
          selectedColor: selectedColor,
        ),
      );
    }

    await _saveCart();
    notifyListeners();
  }

  Future<void> removeFromCart(String itemId) async {
    _cartItems.removeWhere((item) => item.id == itemId);
    await _saveCart();
    notifyListeners();
  }

  Future<void> updateQuantity(String itemId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(itemId);
      return;
    }

    final index = _cartItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
      await _saveCart();
      notifyListeners();
    }
  }

  Future<void> clearCart() async {
    _cartItems.clear();
    await _saveCart();
    notifyListeners();
  }

  bool isInCart(ProductModel product, {String? size, String? color}) {
    return _cartItems.any(
      (item) =>
          item.product.title == product.title &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );
  }

  int getProductQuantity(ProductModel product, {String? size, String? color}) {
    final item = _cartItems.firstWhere(
      (item) =>
          item.product.title == product.title &&
          item.selectedSize == size &&
          item.selectedColor == color,
      orElse: () => CartItemModel(
        id: '',
        product: product,
        quantity: 0,
      ),
    );
    return item.quantity;
  }
}

