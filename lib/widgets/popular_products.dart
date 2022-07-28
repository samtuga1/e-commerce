import 'package:e_commerse/inner_screens/product_detail_page.dart';
import 'package:e_commerse/models/product_model.dart';
import 'package:e_commerse/providers/carts_provider.dart';
import 'package:e_commerse/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    final productAttribute = Provider.of<Product>(context);
    final cartData = Provider.of<CartProvider>(context, listen: false);
    final wishListData = Provider.of<WishListProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailPage.routeName,
                  arguments: productAttribute.id);
            },
            child: Container(
              width: 215,
              child: Stack(
                children: [
                  GridTile(
                    child: Image.network(
                      productAttribute.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                    footer: Container(
                      height: 80,
                      child: GridTileBar(
                        trailing: IconButton(
                          onPressed: cartData.cartItems
                                  .containsKey(productAttribute.id!)
                              ? () {}
                              : () {
                                  cartData.addItemToCart(
                                    productAttribute.id!,
                                    productAttribute.title!,
                                    productAttribute.price!,
                                    productAttribute.imageUrl!,
                                  );
                                  setState(() {});
                                },
                          icon: Icon(
                            !cartData.cartItems
                                    .containsKey(productAttribute.id!)
                                ? Icons.add_shopping_cart
                                : Icons.check,
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: Theme.of(context).backgroundColor,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              productAttribute.title!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textSelectionColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              productAttribute.description!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 3,
                    right: 10,
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.favorite,
                        color: wishListData.favsLists
                                .containsKey(productAttribute.id)
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 85,
                    right: 10,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '\$ ${productAttribute.price}',
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
