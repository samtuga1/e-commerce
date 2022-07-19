import 'package:e_commerse/widgets/wishlist_empty.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/wishlist_screen';
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List wishlists = [];
    return wishlists.isEmpty
        ? Scaffold(
            body: WishlistEmpty(),
          )
        : Scaffold(
            body: Container(),
          );
  }
}
