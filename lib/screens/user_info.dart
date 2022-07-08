import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
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

  bool _themeSwitch = false;

  final List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded
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
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return SizedBox(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titles('User Information'),
                        Divider(),
                        userListTile(0, 'Email', 'Email sub', context),
                        userListTile(0, 'Email', 'Email sub', context),
                        userListTile(0, 'Email', 'Email sub', context),
                        userListTile(0, 'Email', 'Email sub', context),
                        userListTile(0, 'Email', 'Email sub', context),
                        userListTile(0, 'Email', 'Email sub', context),
                        userListTile(1, 'Phone', '', context),
                        userListTile(2, 'Shipping address', '344', context),
                        userListTile(3, 'Joined date', '4/4/4', context),
                        titles('User Settings'),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.wb_sunny),
                          title: Text('Theme'),
                          trailing: Switch.adaptive(
                              value: _themeSwitch,
                              onChanged: (val) {
                                setState(() {
                                  _themeSwitch = val;
                                });
                              }),
                        ),
                        userListTile(4, 'Logout', '', context),
                      ]),
                );
              },
              childCount: 1,
            ),
          )
        ],
      ),
      buildFAB(),
    ]);
  }
}
