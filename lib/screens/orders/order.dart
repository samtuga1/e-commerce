import 'package:e_commerse/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/global_methods.dart';
import 'order_empty.dart';
import 'order_full.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
//   late Future ordersFuture;
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//      Provider.of<OrdersProvider>(context).fetchOrders();
//   }

  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    final orderProvider = Provider.of<OrdersProvider>(context, listen: false);
    // final cartProvider = Provider.of<CartProvider>(context);
    return FutureBuilder(
      future: orderProvider.fetchOrders(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (orderProvider.getOrders.isEmpty) {
          return Scaffold(body: OrderEmpty());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.black,
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                'Orders (${orderProvider.getOrders.length})',
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    // globalMethods.showDialogg(
                    //     'Clear cart!',
                    //     'Your cart will be cleared!',
                    //     () => cartProvider.clearCart(),
                    //     context,
                    // );
                  },
                  icon: Icon(Icons.clear),
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                itemCount: orderProvider.getOrders.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return ChangeNotifierProvider.value(
                    value: orderProvider.getOrders[index],
                    child: OrderFull(),
                  );
                },
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Text('error'),
          );
        }
      },
    );
    // Scaffold(
    //   appBar:
    // AppBar(
    //           foregroundColor: Colors.black,
    //           backgroundColor: Theme.of(context).backgroundColor,
    //           title: Text(
    //             'Orders',
    //           ),
    //           actions: [
    //             IconButton(
    //               onPressed: () {
    //                 // globalMethods.showDialogg(
    //                 //     'Clear cart!',
    //                 //     'Your cart will be cleared!',
    //                 //     () => cartProvider.clearCart(),
    //                 //     context);
    //               },
    //               icon: Icon(Icons.clear),
    //             )
    //           ],
    //         ),
    //   body:
    // );
  }
}
