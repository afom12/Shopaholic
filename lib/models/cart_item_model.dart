import 'package:shop/models/product_model.dart';

class CartItemModel {
  final String id;
  final ProductModel product;
  final int quantity;
  final String? selectedSize;
  final String? selectedColor;

  CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    this.selectedSize,
    this.selectedColor,
  });

  double get totalPrice {
    return (product.priceAfetDiscount ?? product.price) * quantity;
  }

  CartItemModel copyWith({
    String? id,
    ProductModel? product,
    int? quantity,
    String? selectedSize,
    String? selectedColor,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': {
        'image': product.image,
        'brandName': product.brandName,
        'title': product.title,
        'price': product.price,
        'priceAfetDiscount': product.priceAfetDiscount,
        'dicountpercent': product.dicountpercent,
      },
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      product: ProductModel(
        image: json['product']['image'],
        brandName: json['product']['brandName'],
        title: json['product']['title'],
        price: (json['product']['price'] as num).toDouble(),
        priceAfetDiscount: json['product']['priceAfetDiscount'] != null
            ? (json['product']['priceAfetDiscount'] as num).toDouble()
            : null,
        dicountpercent: json['product']['dicountpercent'],
      ),
      quantity: json['quantity'],
      selectedSize: json['selectedSize'],
      selectedColor: json['selectedColor'],
    );
  }
}

