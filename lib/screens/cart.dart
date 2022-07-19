import 'package:e_commerse/widgets/cart_empty.dart';
import 'package:e_commerse/widgets/cart_full.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List products = [2];
    return products.isEmpty
        ? Scaffold(
            body: CartEmpty(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Cart Items Count'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                )
              ],
            ),
            body: Container(
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
