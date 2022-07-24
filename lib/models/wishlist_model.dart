import 'package:flutter/cupertino.dart';

class WishList with ChangeNotifier {
  String? id;
  late String title;
  late double price;
  late String imageUrl;
  WishList({
    this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });
}
