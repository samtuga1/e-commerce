import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/orders_attr.dart';

class OrdersProvider with ChangeNotifier {
  List<OrdersAttr> _orders = [];
  List<OrdersAttr> get getOrders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User _user = _auth.currentUser!;
    String _uid = _user.uid;

    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: _uid)
          .get()
          .then((QuerySnapshot ordersSnapshot) {
        _orders = [];
        ordersSnapshot.docs.forEach((element) {
          print(element.get('title').toString());
          _orders.insert(
              0,
              OrdersAttr(
                orderId: element.get('orderId'),
                productId: element.get('productId'),
                userId: element.get('userId'),
                price: element.get('price').toString(),
                quantity: element.get('quantity').toString(),
                imageUrl: element.get('imageUrl'),
                title: element.get('title'),
                orderDate: element.get('orderDate'),
              ));
        });
      });
    } catch (error) {
      print('Printing error wwhile fetching order $error');

      rethrow;
    }
    notifyListeners();
  }
}
