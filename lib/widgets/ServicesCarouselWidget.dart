import 'dart:async';

import 'package:etime_application/models/services_model.dart';
import 'package:flutter/material.dart';

class ServicesCarouselWidget extends StatefulWidget {
  const ServicesCarouselWidget({super.key});

  @override
  State<ServicesCarouselWidget> createState() => _ServicesCarouselWidgetState();
}

class _ServicesCarouselWidgetState extends State<ServicesCarouselWidget> {
  int _currentSlide = 0;

  PageController _slideController = PageController(
    initialPage: 0,
  );

  List<ServicesModel> servicesList = [
    ServicesModel(
        title: 'КОЙНЫ',
        description: '',
        image: 'assets/rating.jpg',
        banner: ''),
    ServicesModel(
        title: 'ПРАВИЛА',
        description: '',
        image: 'assets/rules.jpg',
        banner: 'assets/rules_banner.jpg'),
    ServicesModel(
        title: 'ЦЕНЫ',
        description: '',
        image: 'assets/price.jpg',
        banner: 'assets/price_banner.jpg'),
    ServicesModel(
        title: 'АКЦИИ',
        description: '',
        image: 'assets/offers.jpg',
        banner: 'assets/offers_banner.jpg'),
    ServicesModel(
        title: 'КОНФИГУРАЦИИ',
        description: '',
        image: 'assets/configs.jpg',
        banner: 'assets/configs_banner.jpg'),
    ServicesModel(
        title: 'ИГРЫ',
        description: '',
        image: 'assets/games.jpg',
        banner: 'assets/games_banner.jpg'),
    ServicesModel(
        title: 'VR ИГРЫ',
        description: '',
        image: 'assets/vr.jpg',
        banner: 'assets/vr_banner.jpg'),
    ServicesModel(
        title: 'ФОТОГРАФИИ',
        description: '',
        image: 'assets/gallery.jpg',
        banner: ''),
  ];

  @override
  void initState() {
    super.initState();
    Timer _timer;
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentSlide < servicesList.length / 2) {
        _currentSlide++;
      } else {
        _currentSlide = 0;
      }

      _slideController.animateToPage(
        _currentSlide,
        duration: Duration(milliseconds: 350),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _slideController,
        scrollDirection: Axis.horizontal,
        itemCount: servicesList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 215,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      scale: 1.0,
                      fit: BoxFit.fill,
                      image: AssetImage(servicesList[index].image),
                    ),
                  ),
                ),
                Text(servicesList[index].title),
              ],
            ),
          );
        });
  }
}
