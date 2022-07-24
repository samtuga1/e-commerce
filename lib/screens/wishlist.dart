import 'package:e_commerse/providers/wishlist_provider.dart';
import 'package:e_commerse/widgets/wishlist_empty.dart';
import 'package:e_commerse/widgets/wishlist_full.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/wishlist_screen';
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favsListData = Provider.of<WishListProvider>(context);
    return favsListData.favsLists.isEmpty
        ? Scaffold(
            body: WishlistEmpty(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Wishlists (${favsListData.favsLists.length})'),
            ),
            body: ListView.builder(
              itemCount: favsListData.favsLists.length,
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: favsListData.favsLists.values.toList()[index],
                child: WishListItem(
                  favItemId: favsListData.favsLists.keys.toList()[index],
                ),
              ),
            ),
          );
  }
}
