// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class IntroSlider extends StatefulWidget {
  const IntroSlider({super.key});

  @override
  State<IntroSlider> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<IntroSlider> {
  List imageList = [
    {"id": 1, "image_path": 'lib/assets/gym-1.jpg'},
    {"id": 2, "image_path": 'lib/assets/gym-2.jpg'},
    {"id": 3, "image_path": 'lib/assets/gym-3.jpg'},
    {"id": 4, "image_path": 'lib/assets/gym-4.jpg'},
  ];
  final CarouselController cl = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {},
                child: CarouselSlider(
                    items: imageList
                        .map((item) => Image.asset(
                              item['image_path'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ))
                        .toList(),
                    carouselController: cl,
                    options: CarouselOptions(
                      autoPlayCurve: Curves.decelerate,
                      scrollPhysics: BouncingScrollPhysics(),
                      autoPlay: true,
                      aspectRatio: 1,
                      height: MediaQuery.of(context).size.height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    )),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageList.asMap().entries.map((entry) {
                    // print(entry);
                    // print(entry.key);
                    return GestureDetector(
                      onTap: () => (entry.key),
                      child: Container(
                        width: currentIndex == entry.key ? 17 : 7,
                        height: 7.0,
                        margin: EdgeInsets.symmetric(horizontal: 3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentIndex == entry.key
                                ? Colors.red
                                : Colors.teal),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
