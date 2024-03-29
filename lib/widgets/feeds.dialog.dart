import 'package:e_commerse/inner_screens/product_detail_page.dart';
import 'package:e_commerse/providers/product_provider.dart';
import 'package:e_commerse/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../consts/colors.dart';
import '../providers/carts_provider.dart';
import '../providers/theme_provider.dart';

class FeedDialog extends StatelessWidget {
  final String productId;
  const FeedDialog({required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context).findById(productId);
    final cartProvider = Provider.of<CartProvider>(context);
    final favs = Provider.of<WishListProvider>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            constraints: BoxConstraints(
                minHeight: 100,
                maxHeight: MediaQuery.of(context).size.height * 0.5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Image.network(
              product.imageUrl!,
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: dialogContent(context, 0, () {
                      favs.addAndRemoveFav(
                        productId,
                        product.title!,
                        product.price!,
                        product.imageUrl!,
                      );
                      Navigator.of(context).pop();
                    }),
                  ),
                  Flexible(
                    child: dialogContent(context, 1, () {
                      Navigator.pushNamed(context, ProductDetailPage.routeName,
                          arguments: productId);
                    }),
                  ),
                  Flexible(
                    child: dialogContent(context, 2, () {
                      cartProvider.addItemToCart(
                        productId,
                        product.title!,
                        product.price!,
                        product.imageUrl!,
                      );
                      Navigator.of(context).pop();
                    }),
                  ),
                ]),
          ),

          /************close****************/
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.3),
              shape: BoxShape.circle,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Colors.grey,
                onTap: () =>
                    Navigator.canPop(context) ? Navigator.pop(context) : null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.close, size: 28, color: Colors.white),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget dialogContent(BuildContext context, int index, Function() fct) {
    final cart = Provider.of<CartProvider>(context);
    final favs = Provider.of<WishListProvider>(context);
    List<IconData> _dialogIcons = [
      favs.favsLists.containsKey(productId)
          ? Icons.favorite
          : Icons.favorite_border,
      Icons.remove_red_eye,
      Icons.shopping_cart,
      Icons.remove,
    ];

    List<String> _texts = [
      favs.favsLists.containsKey(productId) ? 'In wishlist' : 'Add to wishlist',
      'View product',
      cart.cartItems.containsKey(productId) ? 'In Cart ' : 'Add to cart',
    ];
    List<Color?> _colors = [
      favs.favsLists.containsKey(productId)
          ? Colors.red
          : Theme.of(context).textSelectionTheme.selectionColor,
      Theme.of(context).textSelectionTheme.selectionColor,
      Theme.of(context).textSelectionTheme.selectionColor,
    ];
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return FittedBox(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: fct,
          splashColor: Colors.grey,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.25,
            padding: EdgeInsets.all(4),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    // inkwell color
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Icon(
                          _dialogIcons[index],
                          color: _colors[index],
                          size: 25,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(
                    child: Text(
                      _texts[index],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        //  fontSize: 15,
                        color: themeChange.darkTheme
                            ? Theme.of(context).disabledColor
                            : ColorsConsts.subTitle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
