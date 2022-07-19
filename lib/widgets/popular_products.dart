import 'package:flutter/material.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key, this.onTapped}) : super(key: key);
  final Function()? onTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: Material(
          child: InkWell(
            onTap: onTapped,
            child: Container(
              width: 215,
              child: Stack(
                children: [
                  GridTile(
                    child: Image.network(
                      'https://cloudfront-eu-central-1.images.arcpublishing.com/businessoffashion/LT3UDJQBSJCBTJURUJBGJIWKBU.jpg',
                      fit: BoxFit.cover,
                    ),
                    footer: Container(
                      height: 80,
                      child: GridTileBar(
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: Theme.of(context).backgroundColor,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Title',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).textSelectionColor,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Description',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 3,
                    right: 10,
                    child: InkWell(
                      onTap: () {},
                      child: Icon(Icons.favorite),
                    ),
                  ),
                  Positioned(
                    bottom: 85,
                    right: 10,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '\$ 12.00',
                          style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
