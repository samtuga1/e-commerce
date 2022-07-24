import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier {
  final String? id;
  final String? title;
  final int? quantity;
  final String? imageUrl;
  final double? price;

  Cart({this.id, this.title, this.quantity, this.imageUrl, this.price});
}
