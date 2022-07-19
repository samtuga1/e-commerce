import 'package:e_commerse/widgets/wishlist_empty.dart';
import 'package:e_commerse/widgets/wishlist_full.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/wishlist_screen';
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List wishlists = [2];
    return wishlists.isEmpty
        ? Scaffold(
            body: WishlistEmpty(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Wishlists ()'),
            ),
            body: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => WishListItem(),
            ),
          );
  }
}
