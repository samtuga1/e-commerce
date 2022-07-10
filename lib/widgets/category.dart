import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  Category({Key? key, required this.index}) : super(key: key);

  final int index;
  List<Map<String, String>> categoryList = [
    {
      'name': 'Phones',
      'imagePath':
          'https://www.androidauthority.com/wp-content/uploads/2021/12/Google-Pixel-6-Pro-vs-Samsung-Galaxy-S21-Ultra-backs-outside.jpg',
    },
    {
      'name': 'Chlothes',
      'imagePath':
          'https://images.ctfassets.net/3s5io6mnxfqz/3N5iXB8yNlqVQS3xWdIIgX/fa0d654680fbd64eb5852dbbbcf4cca4/AdobeStock_303371265.jpeg?fm=jpg&w=900&fl=progressive',
    },
    {
      'name': 'Shoes',
      'imagePath':
          'https://assets.hermes.com/is/image/hermesproduct/crew-sneaker--211109Z%202D-worn-1-0-0-1000-1000_b.jpg',
    },
    {
      'name': 'Beauty&Health',
      'imagePath':
          'https://cloudfront-eu-central-1.images.arcpublishing.com/businessoffashion/LT3UDJQBSJCBTJURUJBGJIWKBU.jpg',
    },
    {
      'name': 'Laptops',
      'imagePath':
          'https://www.cnet.com/a/img/resize/2d1aa1c93c6b63802ad6374408e4a38467eb1fe6/2022/04/26/0a286fff-7903-48be-b0cb-fa7e29826c53/samsung-galaxy-book-2-pro-360-01.jpg?auto=webp&fit=crop&height=528&width=940',
    },
    {
      'name': 'Furniture',
      'imagePath':
          'https://media.architecturaldigest.com/photos/5f4e9c54072307c75638c0f1/1:1/w_1280%2Cc_limit/Screen%2520Shot%25202020-09-01%2520at%25203.08.43%2520PM.png',
    },
    {
      'name': 'Watches',
      'imagePath':
          'https://media.gq.com/photos/624617325ad2a11cbc735aca/master/pass/watches.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: SizedBox(
          width: 150,
          child: GridTile(
            child: Image.network(
              categoryList[index]['imagePath'] ??
                  'https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png?w=640',
              fit: BoxFit.cover,
            ),
            footer: GridTileBar(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                categoryList[index]['name']!,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Theme.of(context).textSelectionColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
