import 'package:e_commerse/consts/theme_data.dart';
import 'package:e_commerse/inner_screens/product_detail_page.dart';
import 'package:e_commerse/models/dark_theme_sharedpreference.dart';
import 'package:e_commerse/providers/carts_provider.dart';
import 'package:e_commerse/providers/product_provider.dart';
import 'package:e_commerse/providers/theme_provider.dart';
import 'package:e_commerse/providers/wishlist_provider.dart';
import 'package:e_commerse/screens/auth/login.dart';
import 'package:e_commerse/screens/auth/sign_up.dart';
import 'package:e_commerse/screens/cart.dart';
import 'package:e_commerse/screens/feeds.dart';
import 'package:e_commerse/screens/landing_page.dart';
import 'package:e_commerse/screens/main_screen.dart';
import 'package:e_commerse/screens/user_info.dart';
import 'package:e_commerse/screens/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'inner_screens/brands_navigation_rail copy.dart';
import 'inner_screens/category_feeds.dart';
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
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => WishListProvider(),
        ),
      ],
      child: Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: Styles.themeData(themeData.darkTheme, context),
          home: LandingPage(),
          routes: {
            UserInfo.routeName: (context) => UserInfo(),
            BrandNavigationRailScreen.routeName: (context) =>
                BrandNavigationRailScreen(),
            WishlistScreen.routeName: (context) => WishlistScreen(),
            ProductDetailPage.routeName: (context) => ProductDetailPage(),
            CartScreen.routeName: (context) => CartScreen(),
            Feeds.routeName: (context) => Feeds(),
            CategoryFeedsScreen.routeName: (context) => CategoryFeedsScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            BottomBarScreen.routeName: (context) => BottomBarScreen(),
            MainScreen.routeName: (context) => MainScreen(),
          },
        );
      }),
    );
  }
}
