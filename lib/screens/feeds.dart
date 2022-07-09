import 'package:e_commerse/widgets/feeds_products.dart';
import 'package:flutter/material.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FeedProducts(),
    );
  }
}
