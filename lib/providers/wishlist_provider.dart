import 'package:e_commerse/models/wishlist_model.dart';
import 'package:flutter/cupertino.dart';

class WishListProvider with ChangeNotifier {
  Map<String, WishList> _favsLists = {};
  Map<String, WishList> get favsLists => {..._favsLists};
  void addAndRemoveFav(
      String prodId, String title, double price, String imageUrl) {
    if (_favsLists.containsKey(prodId)) {
      deleteWishlist(prodId);
    } else {
      _favsLists.putIfAbsent(
        prodId,
        () => WishList(
          title: title,
          price: price,
          id: DateTime.now().toString(),
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void deleteWishlist(String prodId) {
    _favsLists.remove(prodId);
    notifyListeners();
  }
}
