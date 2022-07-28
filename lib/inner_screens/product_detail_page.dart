import 'package:badges/badges.dart';
import 'package:e_commerse/consts/colors.dart';
import 'package:e_commerse/providers/product_provider.dart';
import 'package:e_commerse/providers/theme_provider.dart';
import 'package:e_commerse/screens/wishlist.dart';
import 'package:e_commerse/widgets/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/carts_provider.dart';
import '../providers/wishlist_provider.dart';
import '../screens/cart.dart';

class ProductDetailPage extends StatefulWidget {
  static const routeName = '/productsDetails';
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  GlobalKey previewContainer = new GlobalKey();
  Widget _details(bool themeState, String title, String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 16, right: 16),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontWeight: FontWeight.w600,
              fontSize: 21.0,
            ),
          ),
          Text(
            info,
            style: TextStyle(
              color: themeState
                  ? Theme.of(context).disabledColor
                  : ColorsConsts.subTitle,
              fontWeight: FontWeight.w500,
              fontSize: 21.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)!.settings.arguments as String;
    final product = Provider.of<Products>(context).findById(id);
    final cartData = Provider.of<CartProvider>(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    final productsData = Provider.of<Products>(context);
    final favsListData = Provider.of<WishListProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
              color: Colors.black12,
            ),
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            child: Image.network(
              product.imageUrl!,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 36, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 250,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.save,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.purple.shade200,
                          onTap: () {},
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                product.title!,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'US \$ ${product.price}',
                              style: TextStyle(
                                fontSize: 21,
                                color: themeState.darkTheme
                                    ? Theme.of(context).disabledColor
                                    : ColorsConsts.subTitle,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 3,
                        indent: 8,
                        endIndent: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          product.description!,
                          style: TextStyle(
                            fontSize: 21,
                            color: themeState.darkTheme
                                ? Theme.of(context).disabledColor
                                : ColorsConsts.subTitle,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 3,
                        indent: 8,
                        endIndent: 8,
                      ),
                      _details(themeState.darkTheme, 'Brand', product.brand!),
                      _details(themeState.darkTheme, 'Quantity',
                          '${product.quantity} Left'),
                      _details(themeState.darkTheme, 'Category',
                          product.productCategoryName!),
                      _details(themeState.darkTheme, 'Popularity',
                          product.isPopular! ? 'Popular' : 'Barely Known'),
                      const SizedBox(
                        height: 15,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                        height: 1,
                      ),
                      Container(
                        color: Theme.of(context).backgroundColor,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'No reviews yet',
                                style: TextStyle(
                                  color: Theme.of(context).disabledColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 21.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Be the first review',
                                style: TextStyle(
                                  color: themeState.darkTheme
                                      ? Theme.of(context).disabledColor
                                      : ColorsConsts.subTitle,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 70,
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Text(
                    'Suggested products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30.0),
                  height: 330,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: productsData.getPopuplarProducts.length,
                    itemBuilder: (context, index) =>
                        ChangeNotifierProvider.value(
                      value: productsData.getPopuplarProducts[index],
                      child: FeedProducts(height: 80),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.grey,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'DETAIL',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(WishlistScreen.routeName);
                  },
                  icon: Consumer<WishListProvider>(
                    builder: (_, favs, ch) => Badge(
                      badgeColor: ColorsConsts.favBadgeColor,
                      animationType: BadgeAnimationType.slide,
                      toAnimate: true,
                      position: BadgePosition.topEnd(),
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
                    builder: (_, carts, ch) => Badge(
                      badgeColor: ColorsConsts.cartBadgeColor,
                      animationType: BadgeAnimationType.slide,
                      toAnimate: true,
                      position: BadgePosition.topEnd(),
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
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: Colors.redAccent.shade400,
                      onPressed: cartData.cartItems.containsKey(product.id)
                          ? () {}
                          : () {
                              cartData.addItemToCart(
                                product.id!,
                                product.title!,
                                product.price!,
                                product.imageUrl!,
                              );
                            },
                      child: Text(
                        cartData.cartItems.containsKey(product.id)
                            ? 'In Cart'
                            : 'ADD TO CART',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      color: Theme.of(context).backgroundColor,
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'BUY NOW',
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.payment,
                            color: Colors.green.shade700,
                            size: 19,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    color: themeState.darkTheme
                        ? Theme.of(context).disabledColor
                        : ColorsConsts.subTitle,
                    child: InkWell(
                      splashColor: ColorsConsts.favColor,
                      onTap: () {
                        favsListData.addAndRemoveFav(
                          product.id!,
                          product.title!,
                          product.price!,
                          product.imageUrl!,
                        );
                      },
                      child: Center(
                        child: favsListData.favsLists.containsKey(product.id!)
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_outline,
                                color: ColorsConsts.white,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
