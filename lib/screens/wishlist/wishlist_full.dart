import 'package:e_commerse/models/wishlist_model.dart';
import 'package:e_commerse/providers/wishlist_provider.dart';
import 'package:e_commerse/services/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../consts/colors.dart';

class WishListItem extends StatefulWidget {
  final String favItemId;
  WishListItem({
    required this.favItemId,
  });
  @override
  _WishListItemState createState() => _WishListItemState();
}

class _WishListItemState extends State<WishListItem> {
  @override
  Widget build(BuildContext context) {
    final prodAttr = Provider.of<WishList>(context);
    final wishListData = Provider.of<WishListProvider>(context);
    GlobalMethods globalMethods = GlobalMethods();
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Material(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
            elevation: 3.0,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      child: Image.network(
                        prodAttr.imageUrl,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            prodAttr.title,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "\$ ${prodAttr.price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        positionedRemove(() {
          globalMethods.showDialogg(
            'Remove wishlist',
            'This product will be removed from wishlists',
            () => wishListData.deleteWishlist(widget.favItemId),
            context,
          );
        }),
      ],
    );
  }

  Widget positionedRemove(Function() fxn) {
    return Positioned(
      top: 20,
      right: 15,
      child: Container(
        height: 30,
        width: 30,
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          padding: EdgeInsets.all(0.0),
          color: ColorsConsts.favColor,
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: fxn,
        ),
      ),
    );
  }
}
