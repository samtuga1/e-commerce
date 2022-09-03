import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerse/models/orders_attr.dart';
import 'package:e_commerse/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../inner_screens/product_detail_page.dart';
import '../../providers/carts_provider.dart';
import '../../providers/theme_provider.dart';
import '../../services/global_methods.dart';

class OrderFull extends StatefulWidget {
  @override
  State<OrderFull> createState() => _OrderFullState();
}

class _OrderFullState extends State<OrderFull> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final orderAttr = Provider.of<OrdersAttr>(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final orderProvider = Provider.of<OrdersProvider>(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetailPage.routeName,
        arguments: orderAttr.productId,
      ),
      child: Container(
        height: 145,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    orderAttr.imageUrl,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            orderAttr.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(32.0),
                            // splashColor: ,
                            onTap: () {
                              globalMethods.showDialogg(
                                'Remove order!',
                                'Order will be deleted',
                                () async {
                                  orderProvider.deleteOrder(orderAttr.orderId);
                                  // setState(() {
                                  //   print('delete');
                                  //   _loading = true;
                                  // });
                                  // await FirebaseFirestore.instance
                                  //     .collection('orders')
                                  //     .doc(orderAttr.orderId)
                                  //     .delete();
                                },
                                context,
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: _loading
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                      size: 22,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Price:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${orderAttr.price}\$',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Quantity:'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'x${orderAttr.quantity}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(child: Text('Order ID: ')),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            '${orderAttr.orderId}\$',
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
