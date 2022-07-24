import 'package:e_commerse/models/cart_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _cartItems = {};
  Map<String, Cart> get cartItems => {..._cartItems};
  double get getTotal {
    double total = 0.0;
    _cartItems.forEach((key, product) {
      total += product.price! * product.quantity!;
    });
    return total;
  }

  void addItemToCart(
      String productId, String title, double price, String imageUrl) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingProduct) => Cart(
          id: existingProduct.id,
          title: existingProduct.title,
          price: existingProduct.price,
          quantity: existingProduct.quantity! + 1,
          imageUrl: existingProduct.imageUrl,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => Cart(
          id: DateTime.now().toString(),
          imageUrl: imageUrl,
          price: price,
          quantity: 1,
          title: title,
        ),
      );
    }
    notifyListeners();
  }
}
