import 'package:e_commerse/providers/theme_provider.dart';
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
  }

  double top = 0.0;
  String? _name;
  String? _userImage;

  final List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded,
    Icons.favorite,
    Icons.chevron_right_rounded,
    Icons.book,
  ];

  Widget userListTile(
      int iconIndex, String title, String subtitle, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          leading: Icon(_userTileIcons[iconIndex]),
          title: Text(title),
          subtitle: Text(subtitle),
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
                    background: FlutterLogo(),
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
                                image: NetworkImage(_userImage ??
                                    'https://post.healthline.com/wp-content/uploads/2020/07/285960-9-Best-Shoe-Brands-for-Bunions_Thumbnail-732x549.jpg'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(_name ?? 'test'),
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
                userListTile(5, 'Wishlist', '', context),
                userListTile(6, 'Cart', '', context),
                userListTile(7, 'My orders', '', context),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: titles('User Information'),
                ),
                Divider(),
                userListTile(0, 'Email', 'Email sub', context),
                userListTile(1, 'Phone', '', context),
                userListTile(2, 'Shipping address', '344', context),
                userListTile(3, 'Joined date', '4/4/4', context),
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
                userListTile(4, 'Logout', '', context),
              ],
            ),
          )
        ],
      ),
      buildFAB(),
    ]);
  }
}
