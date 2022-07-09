import 'package:backdrop/backdrop.dart';
import 'package:e_commerse/consts/colors.dart';
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
    Container(
      color: Colors.white,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BackdropScaffold(
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
          backLayerBackgroundColor: Colors.white70,
          stickyFrontLayer: true,
          frontLayer: _pages[_currentIndex],
          backLayer: BackdropNavigationBackLayer(
            items: [
              ListTile(title: Text("Home")),
              ListTile(title: Text("Widget 2")),
            ],
            onTap: (int position) => {
              setState(() {
                _currentIndex = position;
                print(position);
              }),
            },
          ),
        ),
      ),
    );
  }
}
