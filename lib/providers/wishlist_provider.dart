import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:shop/models/product_model.dart';

class WishlistProvider with ChangeNotifier {
  List<ProductModel> _wishlistItems = [];
  bool _isLoading = false;

  List<ProductModel> get wishlistItems => _wishlistItems;
  bool get isLoading => _isLoading;

  int get itemCount => _wishlistItems.length;

  bool get isEmpty => _wishlistItems.isEmpty;

  WishlistProvider() {
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final wishlistData = prefs.getString('wishlist_items');
      
      if (wishlistData != null) {
        final List<dynamic> decoded = json.decode(wishlistData);
        _wishlistItems = decoded
            .map((item) => ProductModel(
                  image: item['image'],
                  brandName: item['brandName'],
                  title: item['title'],
                  price: (item['price'] as num).toDouble(),
                  priceAfetDiscount: item['priceAfetDiscount'] != null
                      ? (item['priceAfetDiscount'] as num).toDouble()
                      : null,
                  dicountpercent: item['dicountpercent'],
                ))
            .toList();
      }
    } catch (e) {
      debugPrint('Error loading wishlist: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveWishlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final wishlistData = json.encode(
        _wishlistItems.map((product) => {
          'image': product.image,
          'brandName': product.brandName,
          'title': product.title,
          'price': product.price,
          'priceAfetDiscount': product.priceAfetDiscount,
          'dicountpercent': product.dicountpercent,
        }).toList(),
      );
      await prefs.setString('wishlist_items', wishlistData);
    } catch (e) {
      debugPrint('Error saving wishlist: $e');
    }
  }

  Future<void> addToWishlist(ProductModel product) async {
    if (!isInWishlist(product)) {
      _wishlistItems.add(product);
      await _saveWishlist();
      notifyListeners();
    }
  }

  Future<void> removeFromWishlist(ProductModel product) async {
    _wishlistItems.removeWhere(
      (item) => item.title == product.title && item.image == product.image,
    );
    await _saveWishlist();
    notifyListeners();
  }

  Future<void> toggleWishlist(ProductModel product) async {
    if (isInWishlist(product)) {
      await removeFromWishlist(product);
    } else {
      await addToWishlist(product);
    }
  }

  Future<void> clearWishlist() async {
    _wishlistItems.clear();
    await _saveWishlist();
    notifyListeners();
  }

  bool isInWishlist(ProductModel product) {
    return _wishlistItems.any(
      (item) => item.title == product.title && item.image == product.image,
    );
  }
}

