import 'search.dart';
import 'package:flutter/material.dart';
import 'user_info.dart';
import 'cart.dart';
import 'feeds.dart';
import 'home.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late List<Map<String, Widget>> _pages;
  int _selectedPageIndex = 4;

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
        'page': Cart(),
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
        // color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 0.98,
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
              unselectedItemColor: Theme.of(context).textSelectionColor,
              selectedItemColor: Colors.purple,
              currentIndex: _selectedPageIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.rss_feed),
                  title: Text('Feeds'),
                ),
                BottomNavigationBarItem(
                  activeIcon: null,
                  icon: Icon(null),
                  title: Text('Search'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.shopping_bag,
                  ),
                  title: Text('Cart'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('User'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          hoverElevation: 10,
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
