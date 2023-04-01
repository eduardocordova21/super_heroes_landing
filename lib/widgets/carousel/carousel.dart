import 'package:flutter/material.dart';
import 'package:super_heroes_landing/models/thumbnail.dart';
import 'package:super_heroes_landing/widgets/carousel/slider_carousel.dart';

import '../../controllers/characters_controller.dart';
import '../../models/results.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final CharactersController _charactersController = CharactersController();
  final PageController _pageController =
      PageController(viewportFraction: 0.8, initialPage: 1);

  late final List<Results> _charactersList = [];
  late final List<String> _thumbnailList = [];
  int activePage = 1;

  @override
  void initState() {
    super.initState();

    _charactersController.fetchCharacters().then((response) => {
          for (var character in response.requestdata.results)
            {
              if (_charactersList.length < 5) {_charactersList.add(character)}
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            itemCount: _charactersList.length,
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
                  charactersList: _charactersList,
                  index: index,
                  active: active);
            },
          ),
        ),
      ],
    );
  }
}
