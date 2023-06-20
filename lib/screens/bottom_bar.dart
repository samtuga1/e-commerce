import 'package:e_commerse/widgets/home.dart';
import 'cart/cart.dart';
import 'search.dart';
import 'package:flutter/material.dart';
import 'user_info.dart';
import 'feeds.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/bottom_bar';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late List<Map<String, Widget>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': Home(),
      },
      {
        'page': Feeds(),
      },
      {
        'page': Search(),
      },
      {
        'page': CartScreen(),
      },
      {
        'page': UserInfo(),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          child: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Theme.of(context).primaryColor,
            unselectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            selectedItemColor: Colors.purple,
            currentIndex: _selectedPageIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.rss_feed),
                // title: Text('Feeds'),
                label: 'Feeds',
              ),
              BottomNavigationBarItem(
                activeIcon: null,
                icon: Icon(null),
                // title: Text('Search'),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag,
                ),
                // title: Text('Cart'),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                //  title: Text('User'),
                label: 'User',
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          hoverElevation: 10,
          backgroundColor: Colors.purple,
          splashColor: Colors.grey,
          tooltip: 'Search',
          elevation: 4,
          child: Icon(Icons.search),
          onPressed: () => setState(() {
            _selectedPageIndex = 2;
          }),
        ),
      ),
    );
  }
}
