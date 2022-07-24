import 'package:backdrop/backdrop.dart';
import 'package:e_commerse/consts/colors.dart';
import 'package:e_commerse/screens/cart.dart';
import 'package:e_commerse/screens/feeds.dart';
import 'package:e_commerse/screens/wishlist.dart';
import 'package:flutter/material.dart';
import '../widgets/home_home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List _pages = [
    HomeHome(),
    Feeds(),
    CartScreen(),
    WishlistScreen(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BackdropScaffold(
          frontLayerBorderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: BackdropAppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorsConsts.starterColor,
                    ColorsConsts.endColor,
                  ],
                ),
              ),
            ),
            leading: BackdropToggleButton(
              icon: AnimatedIcons.home_menu,
            ),
            title: Text("Navigation Example"),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  radius: 17.5,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1656051171336-f7430be33a4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8OHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
                ),
              )
            ],
          ),
          backLayerBackgroundColor: ColorsConsts.starterColor.withOpacity(0.5),
          stickyFrontLayer: false,
          frontLayer: _pages[_currentIndex],
          backLayer: BackdropNavigationBackLayer(
            items: [
              CustomDropDownListTile(
                title: 'Home',
                icon: Icons.home,
              ),
              CustomDropDownListTile(
                title: 'Feed',
                icon: Icons.rss_feed_rounded,
              ),
              CustomDropDownListTile(
                title: 'Cart',
                icon: Icons.rss_feed_rounded,
              ),
              CustomDropDownListTile(
                title: 'Wishlist',
                icon: Icons.rss_feed_rounded,
              ),
              CustomDropDownListTile(
                title: 'Upload a new product',
                icon: Icons.rss_feed_rounded,
              ),
            ],
            onTap: (int position) => {
              setState(() {
                _currentIndex = position;
              }),
            },
          ),
        ),
      ),
    );
  }
}

class CustomDropDownListTile extends StatelessWidget {
  const CustomDropDownListTile({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            width: 16,
          ),
          Icon(icon),
        ],
      ),
    );
  }
}
