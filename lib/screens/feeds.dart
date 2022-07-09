import 'package:e_commerse/widgets/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: MasonryGridView.count(
        padding: EdgeInsets.all(3),
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemCount: 10,
        itemBuilder: (context, index) => FeedProducts(
          height: index % 2 == 0 ? 310 : 270,
        ),
      ),
    ));
  }
}
