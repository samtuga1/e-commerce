import 'package:badges/badges.dart' as ba;
import 'package:e_commerse/providers/product_provider.dart';
import 'package:e_commerse/screens/cart/cart.dart';
import 'package:e_commerse/screens/wishlist/wishlist.dart';
import 'package:e_commerse/widgets/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../consts/colors.dart';
import '../models/product_model.dart';
import '../providers/carts_provider.dart';
import '../providers/wishlist_provider.dart';

class Feeds extends StatefulWidget {
  static const routeName = '/feeds';
  Feeds({Key? key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  Future<void> getProducts() async {
    Provider.of<Products>(context, listen: false).fetchProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    List<Product> products = productsData.products;
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs == 'popular') {
      products = productsData.getPopuplarProducts;
    }
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Feeds',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Theme.of(context).cardColor,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(WishlistScreen.routeName);
                },
                icon: Consumer<WishListProvider>(
                  builder: (_, favs, ch) => ba.Badge(
                    badgeColor: ColorsConsts.favBadgeColor,
                    animationType: ba.BadgeAnimationType.slide,
                    toAnimate: true,
                    position: ba.BadgePosition.topEnd(),
                    badgeContent: Text(
                      favs.favsLists.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: ColorsConsts.favColor,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: Consumer<CartProvider>(
                  builder: (_, carts, ch) => ba.Badge(
                    badgeColor: ColorsConsts.cartBadgeColor,
                    animationType: ba.BadgeAnimationType.slide,
                    toAnimate: true,
                    position: ba.BadgePosition.topEnd(),
                    badgeContent: Text(
                      carts.cartItems.length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(
                      Icons.shopping_cart,
                      color: ColorsConsts.cartColor,
                    ),
                  ),
                ),
              )
            ]),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: getProducts,
            child: MasonryGridView.count(
              padding: EdgeInsets.all(3),
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: products.length,
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: products[index],
                child: FeedProducts(
                  height: index % 2 == 0 ? 310 : 350,
                ),
              ),
            ),
          ),
        ));
  }
}
