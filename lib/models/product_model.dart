import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  String? id;
  String? title;
  String? description;
  double? price;
  String? imageUrl;
  String? productCategoryName;
  String? brand;
  int? quantity;
  bool? isFavorite;
  bool? isPopular;

  Product({
    this.id,
    this.title,
    this.brand,
    this.description,
    this.imageUrl,
    this.isFavorite,
    this.isPopular,
    this.price,
    this.productCategoryName,
    this.quantity,
  });
}
