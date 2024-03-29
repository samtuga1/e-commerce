import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerse/providers/product_provider.dart';
import 'package:e_commerse/screens/feeds.dart';
import 'package:e_commerse/widgets/category.dart';
import 'package:e_commerse/widgets/popular_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../inner_screens/brands_navigation_rail copy.dart';

class Home extends StatelessWidget {
  Home({
    Key? key,
  }) : super(key: key);

  final List<String> carousels = [
    'assets/images/carousel1.png',
    'assets/images/carousel2.jpeg',
    'assets/images/carousel3.jpg',
    'assets/images/carousel4.png',
  ];

  final List<String> popularBrands = [
    'assets/images/addidas.jpg',
    'assets/images/apple.jpg',
    'assets/images/Dell.jpg',
    'assets/images/h&m.jpg',
    'assets/images/nike.jpg',
    'assets/images/samsung.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    productsData.fetchProducts();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                  options: CarouselOptions(
                    height: 130,
                    autoPlay: true,
                  ),
                  items: List.generate(
                    carousels.length,
                    (index) => SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        carousels[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return Category(index: index);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Brands',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          BrandNavigationRailScreen.routeName,
                          arguments: {7},
                        );
                      },
                      child: Text(
                        'View all...',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: Swiper(
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        popularBrands[index],
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  onTap: (index) {
                    print(index);
                    Navigator.of(context).pushNamed(
                      BrandNavigationRailScreen.routeName,
                      arguments: {
                        index,
                      },
                    );
                  },
                  itemCount: 5,
                  viewportFraction: 0.8,
                  scale: 0.9,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Products',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(Feeds.routeName, arguments: 'popular');
                      },
                      child: Text(
                        'View all...',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 285,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productsData.getPopuplarProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider.value(
                          value: productsData.getPopuplarProducts[index],
                        ),
                        // ChangeNotifierProvider(
                        //   create: (ctx) => WishListProvider(),
                        // ),
                      ],
                      child: PopularProducts(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
