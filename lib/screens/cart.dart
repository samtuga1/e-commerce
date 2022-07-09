import 'package:e_commerse/widgets/cart_empty.dart';
import 'package:e_commerse/widgets/cart_full.dart';
import 'package:flutter/material.dart';

import '../consts/colors.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget checkoutSection(BuildContext ctx) {
      return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.5,
              color: Colors.grey,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
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
                      onTap: () {},
                      borderRadius: BorderRadius.circular(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Checkout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(ctx).textSelectionColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Total:  ',
                style: TextStyle(
                  color: Theme.of(ctx).textSelectionColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'US\$400.00',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    List products = [2];
    return Scaffold(
      appBar: products.isNotEmpty
          ? AppBar(
              title: Text('Cart Items Count'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                )
              ],
            )
          : null,
      bottomSheet: products.isNotEmpty ? checkoutSection(context) : null,
      body: products.isEmpty
          ? CartEmpty()
          : Container(
              margin: const EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return CartFull();
                },
              ),
            ),
    );
  }
}
