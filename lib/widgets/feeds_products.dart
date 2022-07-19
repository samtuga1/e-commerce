import 'package:badges/badges.dart';
import 'package:e_commerse/inner_screens/product_detail_page.dart';
import 'package:flutter/material.dart';

class FeedProducts extends StatefulWidget {
  const FeedProducts({Key? key, required this.height}) : super(key: key);
  final double height;
  @override
  _FeedProductsState createState() => _FeedProductsState();
}

class _FeedProductsState extends State<FeedProducts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(ProductDetailPage.routeName);
        },
        child: Container(
          height: widget.height,
          width: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).backgroundColor),
          child: Column(
            children: [
              Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                        minHeight: 100,
                        maxHeight: MediaQuery.of(context).size.height * 0.3),
                    child: Image.network(
                      'https://post.healthline.com/wp-content/uploads/2020/07/285960-9-Best-Shoe-Brands-for-Bunions_Thumbnail-732x549.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Badge(
                  toAnimate: true,
                  shape: BadgeShape.square,
                  badgeColor: Colors.pink,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                  ),
                  badgeContent:
                      Text('New', style: TextStyle(color: Colors.white)),
                ),
              ]),
              Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(left: 5, bottom: 2, right: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Description',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '\$ 158.99',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantity: 12',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(18.0),
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
