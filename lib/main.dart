import 'package:e_commerse/consts/theme_data.dart';
import 'package:e_commerse/models/dark_theme_sharedpreference.dart';
import 'package:e_commerse/providers/theme_provider.dart';
import 'package:e_commerse/screens/user_info.dart';
import 'package:e_commerse/screens/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'inner_screens/brands_navigation_rail copy.dart';
import 'screens/bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  DarkThemeProvider _themeProvider = DarkThemeProvider();

  void getCurrentTheme() async {
    _themeProvider.darkTheme = await _themeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => _themeProvider,
        ),
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: Styles.themeData(themeData.darkTheme, context),
          home: BottomBarScreen(),
          routes: {
            UserInfo.routeName: (context) => UserInfo(),
            BrandNavigationRailScreen.routeName: (context) =>
                BrandNavigationRailScreen(),
            WishlistScreen.routeName: (context) => WishlistScreen(),
          },
        );
      }),
    );
  }
}
