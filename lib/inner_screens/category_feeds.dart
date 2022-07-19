import 'package:e_commerse/providers/product_provider.dart';
import 'package:e_commerse/widgets/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';

class CategoryFeedsScreen extends StatelessWidget {
  static const routeName = '/category_feeds';
  CategoryFeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryName = ModalRoute.of(context)!.settings.arguments as String;
    List<Product> categoryProductList =
        Provider.of<Products>(context).findByCategory(categoryName);
    return Scaffold(
        body: SafeArea(
      child: MasonryGridView.count(
        padding: EdgeInsets.all(3),
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemCount: categoryProductList.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: categoryProductList[index],
          child: FeedProducts(
            height: index % 2 == 0 ? 310 : 350,
          ),
        ),
      ),
    ));
  }
}
