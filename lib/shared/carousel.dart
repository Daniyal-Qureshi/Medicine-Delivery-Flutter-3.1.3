import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  final List<String> imageList = [
    "assets/arinac.jpeg",
    "assets/augmentin.jpeg",
    "assets/brufen.jpg",
    "assets/disprin.jpg",
    "assets/folic.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          autoPlay: true,
        ),
        items: imageList
            .map((e) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(e, width: 100, height: 200, fit: BoxFit.cover)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
