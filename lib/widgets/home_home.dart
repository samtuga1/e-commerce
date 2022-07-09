import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeHome extends StatelessWidget {
  HomeHome({
    Key? key,
  }) : super(key: key);

  final List<String> carousels = [
    'assets/images/carousel1.png',
    'assets/images/carousel2.png',
    'assets/images/carousel3.png',
    'assets/images/carousel1.png',
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 15.6 / 9,
                autoPlay: true,
              ),
              items: List.generate(
                carousels.length,
                (index) => Image.asset(
                  carousels[index],
                  fit: BoxFit.fill,
                ),
              )),
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
                Text(
                  'View all...',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    popularBrands[index],
                    fit: BoxFit.fill,
                  ),
                );
              },
              itemCount: 5,
              viewportFraction: 0.8,
              scale: 0.9,
            ),
          )
        ],
      ),
    );
  }
}
