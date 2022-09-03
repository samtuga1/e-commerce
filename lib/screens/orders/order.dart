import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/global_methods.dart';
import 'order_empty.dart';
import 'order_full.dart';

class OrderScreen extends StatefulWidget {
  //To be known 1) the amount must be an integer 2) the amount must not be double 3) the minimum amount should be less than 0.5 $
  static const routeName = '/OrderScreen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   StripeService.init();
  // }

  // void payWithCard({int amount}) async {
  //   ProgressDialog dialog = ProgressDialog(context);
  //   dialog.style(message: 'Please wait...');
  //   await dialog.show();
  //   var response = await StripeService.payWithNewCard(
  //       currency: 'USD', amount: amount.toString());
  //   await dialog.hide();
  //   print('response : ${response.message}');
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     content: Text(response.message),
  //     duration: Duration(milliseconds: response.success == true ? 1200 : 3000),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    // final cartProvider = Provider.of<CartProvider>(context);
    bool isOrder = false;
    return isOrder
        ? Scaffold(body: OrderEmpty())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text('Orders ()'),
              actions: [
                IconButton(
                  onPressed: () {
                    // globalMethods.showDialogg(
                    //     'Clear cart!',
                    //     'Your cart will be cleared!',
                    //     () => cartProvider.clearCart(),
                    //     context);
                  },
                  icon: Icon(Icons.remove),
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (BuildContext ctx, int index) {
                    return OrderFull();
                  }),
            ),
          );
  }
}
