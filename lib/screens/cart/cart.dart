import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerse/screens/cart/cart_empty.dart';
import 'package:e_commerse/screens/cart/cart_full.dart';
import 'package:e_commerse/services/global_methods.dart';
import 'package:e_commerse/services/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../consts/colors.dart';
import '../../providers/carts_provider.dart';
import 'package:http/http.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/CartScreen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Future<void> initPay() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   Stripe.publishableKey =
  //       "pk_test_51Lb4SIJzczR0qFxUC0sES4Q1LTG3VBOP3BDWswQBCP8ZwbdTSZNWps78nRON9XjSfuNCGAVyfURSVFBqr7US4h9Z00utuq0vjp";
  //   await Stripe.instance.applySettings();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   initPay();
  // }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();
    return cartData.cartItems.isEmpty
        ? Scaffold(body: CartEmpty())
        : Scaffold(
            bottomSheet: checkoutSection(context, cartData.getTotal),
            appBar: AppBar(
              title: Text('Cart Items Count'),
              actions: [
                IconButton(
                  onPressed: () {
                    globalMethods.showDialogg(
                      'Clear cart',
                      'All products in the cart will be cleard',
                      () => cartData.clearAll(),
                      context,
                    );
                  },
                  icon: Icon(Icons.delete),
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: cartData.cartItems.values.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ChangeNotifierProvider.value(
                      value: cartData.cartItems.values.toList()[index],
                      child: CartFull(
                        prodId: cartData.cartItems.keys.toList()[index],
                      ),
                    );
                  }),
            ),
          );
  }

  Widget checkoutSection(BuildContext ctx, double total) {
    var uuid = Uuid();
    final auth = FirebaseAuth.instance.currentUser;
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            /// mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                    color: Theme.of(ctx).textSelectionColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'US \$$total',
                //textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(colors: [
                      ColorsConsts.gradiendLStart,
                      ColorsConsts.gradiendLEnd,
                    ], stops: [
                      0.0,
                      0.7
                    ]),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        print('pressed');
                        double amountInCent = total * 1000;
                        int intAmount = (amountInCent / 10).ceil();
                        Payment.initPayment(
                          email: 'test@gmail.com',
                          amount: intAmount.toString(),
                          context: context,
                        ).then((response) {
                          if (response!['success'] == true) {
                            try {
                              cartProvider.cartItems
                                  .forEach((key, orderValue) async {
                                final orderId = uuid.v4();
                                await FirebaseFirestore.instance
                                    .collection('orders')
                                    .doc(orderId)
                                    .set({
                                  'orderId': orderId,
                                  'userId': auth?.uid,
                                  'productId': orderValue.productId,
                                  'title': orderValue.title,
                                  'price': orderValue.price! *
                                      orderValue.quantity!.toDouble(),
                                  'imageUrl': orderValue.imageUrl,
                                  'quantity': orderValue.quantity,
                                  'orderDate': Timestamp.now(),
                                });
                              });
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Payment was successful'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          } else {
                            return;
                          }
                        });
                      },
                      splashColor: Theme.of(ctx).splashColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Checkout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(ctx).textSelectionColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
