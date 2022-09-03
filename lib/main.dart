import 'dart:developer';
import 'package:e_commerse/consts/theme_data.dart';
import 'package:e_commerse/firebase_options.dart';
import 'package:e_commerse/inner_screens/product_detail_page.dart';
import 'package:e_commerse/providers/carts_provider.dart';
import 'package:e_commerse/providers/product_provider.dart';
import 'package:e_commerse/providers/theme_provider.dart';
import 'package:e_commerse/providers/wishlist_provider.dart';
import 'package:e_commerse/screens/auth/forget_password.dart';
import 'package:e_commerse/screens/auth/login.dart';
import 'package:e_commerse/screens/auth/sign_up.dart';
import 'package:e_commerse/screens/cart/cart.dart';
import 'package:e_commerse/screens/feeds.dart';
import 'package:e_commerse/screens/main_screen.dart';
import 'package:e_commerse/screens/orders/order.dart';
import 'package:e_commerse/screens/user_info.dart';
import 'package:e_commerse/screens/user_state.dart';
import 'package:e_commerse/screens/wishlist/wishlist.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'inner_screens/brands_navigation_rail copy.dart';
import 'inner_screens/category_feeds.dart';
import 'screens/bottom_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51Lb4SIJzczR0qFxUC0sES4Q1LTG3VBOP3BDWswQBCP8ZwbdTSZNWps78nRON9XjSfuNCGAVyfURSVFBqr7US4h9Z00utuq0vjp";
  Stripe.instance.applySettings();
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

  final initialize = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialize,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          log(snapshot.error.toString());
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Firebase Initialize Error'),
              ),
            ),
          );
        } else {
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
            child: Consumer<DarkThemeProvider>(
                builder: (context, themeData, child) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: Styles.themeData(themeData.darkTheme, context),
                home: UserState(),
                routes: {
                  UserInfo.routeName: (context) => UserInfo(),
                  BrandNavigationRailScreen.routeName: (context) =>
                      BrandNavigationRailScreen(),
                  WishlistScreen.routeName: (context) => WishlistScreen(),
                  ProductDetailPage.routeName: (context) => ProductDetailPage(),
                  CartScreen.routeName: (context) => CartScreen(),
                  Feeds.routeName: (context) => Feeds(),
                  CategoryFeedsScreen.routeName: (context) =>
                      CategoryFeedsScreen(),
                  LoginScreen.routeName: (context) => LoginScreen(),
                  SignUpScreen.routeName: (context) => SignUpScreen(),
                  BottomBarScreen.routeName: (context) => BottomBarScreen(),
                  MainScreen.routeName: (context) => MainScreen(),
                  ForgetPassword.routeName: (context) => ForgetPassword(),
                  OrderScreen.routeName: (context) => OrderScreen(),
                },
              );
            }),
          );
        }
      },
    );
  }
}
