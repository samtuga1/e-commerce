import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerse/providers/theme_provider.dart';
import 'package:e_commerse/screens/cart/cart.dart';
import 'package:e_commerse/screens/orders/order.dart';
import 'package:e_commerse/screens/wishlist/wishlist.dart';
import 'package:e_commerse/services/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatefulWidget {
  static const routeName = 'UserInfo';
  UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {});
    });
    getData();
  }

  double top = 0.0;
  String? _name;
  String? _userImage;
  String? _joinedAt;
  String? _email;
  int? phoneNumber;
  final FirebaseAuth auth = FirebaseAuth.instance;

  GlobalMethods _globalMethods = GlobalMethods();

  void getData() async {
    final user = auth.currentUser;
    final _uid = user!.uid;
    try {
      final userDoc = user.isAnonymous
          ? null
          : await FirebaseFirestore.instance
              .collection('users')
              .doc(_uid)
              .get();
      if (userDoc == null) {
        return;
      }
      setState(() {
        _name = userDoc.get('name') ?? user.displayName;
        _email = userDoc.get('email') ?? user.email;
        _joinedAt = userDoc.get('joinedAt');
        phoneNumber = userDoc.get('phoneNumber');
        _userImage = userDoc.get('imageUrl') ?? user.photoURL;
      });
    } catch (error) {
      print(error);
    }
  }

  final List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded,
    Icons.favorite,
    Icons.chevron_right_rounded,
    Icons.book,
    Icons.shopping_bag,
  ];

  Widget userListTile(int iconIndex, String title, String subtitle,
      BuildContext context, int? trailingIconIndex, Function() onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          leading: Icon(_userTileIcons[iconIndex]),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: trailingIconIndex != null
              ? Icon(_userTileIcons[trailingIconIndex])
              : null,
        ),
      ),
    );
  }

  Widget titles(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }

  Widget buildFAB() {
    final double defaultTopMargin = 200 - 12;
    final double scaleStart = 100;
    final double scaleEnd = scaleStart / 2;
    double top = defaultTopMargin;
    double scale = 1;
    if (_scrollController.hasClients) {
      final offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        scale = 0.0;
      }
    }
    return Positioned(
      top: top,
      right: 16,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          heroTag: 'btn1',
          child: Icon(Icons.camera),
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context, listen: false);
    return Stack(children: [
      CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            elevation: 5,
            automaticallyImplyLeading: true,
            backgroundColor: Colors.red,
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                top = constraints.biggest.height;
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset(0, 0),
                      end: FractionalOffset(1, 0),
                      stops: [0, 1],
                      colors: [Colors.purple, Colors.white],
                    ),
                  ),
                  child: FlexibleSpaceBar(
                    background: Image.network(
                      _userImage ??
                          "https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=",
                      fit: BoxFit.cover,
                    ),
                    centerTitle: true,
                    title: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: top <= 110 ? 1 : 0,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: kToolbarHeight / 1.8,
                            width: kToolbarHeight / 1.8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 1.0,
                                ),
                              ],
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  _userImage ??
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTL_JlCFnIGX5omgjEjgV9F3sBRq14eTERK9w&usqp=CAU',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(_name ?? 'Guest'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: titles('User Bag'),
                ),
                Divider(),
                userListTile(5, 'Wishlist', '', context, 6, () {
                  Navigator.of(context).pushNamed(WishlistScreen.routeName);
                }),
                userListTile(8, 'Cart', '', context, 6, () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
                userListTile(7, 'My orders', '', context, 6, () {
                  Navigator.of(context).pushNamed(OrderScreen.routeName);
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: titles('User Information'),
                ),
                Divider(),
                userListTile(
                    0, 'Email', '${_email ?? ''} ', context, null, () {}),
                userListTile(
                    1, 'Phone', '${phoneNumber ?? ''} ', context, null, () {}),
                userListTile(
                    2, 'Shipping address', '344', context, null, () {}),
                userListTile(3, 'Joined date', '${_joinedAt ?? ' '} ', context,
                    null, () {}),
                titles('User Settings'),
                Divider(),
                ListTile(
                    leading: Icon(Icons.wb_sunny),
                    title: Text('Theme'),
                    trailing: CupertinoSwitch(
                      value: themeData.darkTheme,
                      onChanged: (val) {
                        setState(
                          () {
                            themeData.darkTheme = val;
                          },
                        );
                      },
                    )
                    // Switch.adaptive(
                    //   value: _themeSwitch,
                    //   onChanged: (val) {
                    //     setState(
                    //       () {
                    //         _themeSwitch = val;
                    //       },
                    //     );
                    //   },
                    // ),
                    ),
                userListTile(4, 'Logout', '', context, null, () {
                  // Navigator.canPop(context)
                  //     ? Navigator.of(context).pop()
                  //     : null;
                  _globalMethods.showLogoutDialog(
                      () => auth.signOut(), context);
                }),
              ],
            ),
          )
        ],
      ),
      buildFAB(),
    ]);
  }
}
