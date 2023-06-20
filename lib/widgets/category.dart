import 'package:e_commerse/inner_screens/category_feeds.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  Category({Key? key, required this.index}) : super(key: key);

  final int index;
  List<Map<String, String>> categoryList = [
    {
      'name': 'Phones',
      'imagePath': 'assets/images/phone-category.jpg',
    },
    {
      'name': 'Clothes',
      'imagePath': 'assets/images/clothes-category.jpeg',
    },
    {
      'name': 'Shoes',
      'imagePath': 'assets/images/sneaker-category.jpg',
    },
    {
      'name': 'Beauty & health',
      'imagePath': 'assets/images/beauty-category.jpg',
    },
    {
      'name': 'Laptops',
      'imagePath': 'assets/images/laptops-category.jpg',
    },
    {
      'name': 'Furniture',
      'imagePath': 'assets/images/furniture-category.jpg',
    },
    {
      'name': 'Watches',
      'imagePath': 'assets/images/watches-category.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(CategoryFeedsScreen.routeName,
              arguments: categoryList[index]['name']);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: SizedBox(
            width: 150,
            child: GridTile(
              child: Image.asset(
                categoryList[index]['imagePath'] ??
                    'https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png?w=640',
                fit: BoxFit.cover,
              ),
              footer: GridTileBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Text(
                  categoryList[index]['name']!,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
