import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ucourses/core/constants/app_text.dart';
import 'package:ucourses/core/constants/app_text_styles.dart';

import '../widgets/carousel_item.dart'; // Ensure this file path is correct

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  _HomeCarouselState createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  final List<CarouselItem> carouselItems = [
    CarouselItem('lib/assets/images/style/carousel_one.webp', AppTexts.aiCourse,
        AppTexts.aiCourseDescription),
    CarouselItem('lib/assets/images/style/carousel_two.webp',
        AppTexts.dataCourse, AppTexts.dataCourseDescription),
    CarouselItem('lib/assets/images/style/carousel_three.webp',
        AppTexts.pythonCourse, AppTexts.pythonCourseDescription),
    CarouselItem('lib/assets/images/style/carousel_four.webp',
        AppTexts.mechanicalCourse, AppTexts.mechanicalCourseDescription),
    CarouselItem('lib/assets/images/style/carousel_five.webp',
        AppTexts.csCourse, AppTexts.csCourseDescription),
  ];

  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider(
                carouselController: _controller,
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 25       /   10 ,
                  enlargeCenterPage: true,
                  viewportFraction: 0.4,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items: carouselItems
                    .map((item) => Builder(
                          builder: (BuildContext context) {
                            return Material(
                              elevation: 9.0,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 230, 230, 230),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(10)),
                                        child: Image.asset(item.imageUrl,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(item.title,
                                          style: Styles.styleBold),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        item.description,
                                        style: Styles.style16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ))
                    .toList(),
              ),
              Positioned(
                left: 10, // Adjust the position as needed
                child: FloatingActionButton(
                  onPressed: () => _controller.previousPage(),
                  mini: true,
                  backgroundColor: Colors.purple,
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              Positioned(
                right: 10, // Adjust the position as needed
                child: FloatingActionButton(
                  onPressed: () => _controller.nextPage(),
                  mini: true,
                  backgroundColor: Colors.purple,
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: carouselItems.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (_current == entry.key ? Colors.purple : Colors.grey)
                        .withOpacity(0.9),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
