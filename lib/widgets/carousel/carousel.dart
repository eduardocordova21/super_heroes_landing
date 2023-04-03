import 'package:flutter/material.dart';
import 'package:super_heroes_landing/widgets/carousel/slider_carousel.dart';

import '../../models/results.dart';

class Carousel extends StatefulWidget {
  List<Results> charactersList = [];

  Carousel({Key? key, required this.charactersList}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final PageController _pageController =
      PageController(viewportFraction: 0.8, initialPage: 1);

  int activePage = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('carousel'),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            itemCount: widget.charactersList.length,
            pageSnapping: true,
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                activePage = page;
              });
            },
            itemBuilder: (context, index) {
              bool active = index == activePage;
              return SliderCarousel(
                  charactersList: widget.charactersList,
                  index: index,
                  active: active);
            },
          ),
        ),
      ],
    );
  }
}
