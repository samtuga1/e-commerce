import 'package:e_commerse/inner_screens/upload_product_form.dart';
import 'package:flutter/material.dart';
import 'bottom_bar.dart';

class MainScreen extends StatelessWidget {
  static const routeName = 'main_page';
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        BottomBarScreen(),
        UploadProductForm(),
      ],
    );
  }
}
