import 'package:etime_application/models/goods_model.dart';
import 'package:flutter/material.dart';

class GoodsCarouselWidget extends StatefulWidget {
  const GoodsCarouselWidget({super.key});

  @override
  State<GoodsCarouselWidget> createState() => _GoodsCarouselWidgetState();
}

class _GoodsCarouselWidgetState extends State<GoodsCarouselWidget> {
  List<GoodsModel> _goodsList = [
    GoodsModel(
        title: 'Час игры',
        article: '1',
        image: 'assets/goods/1.jpg',
        price: '110 ₽'),
    GoodsModel(
        title: 'Три часа игры',
        article: '3',
        image: 'assets/goods/2.jpg',
        price: '250 ₽'),
    GoodsModel(
        title: 'Пять часов игры',
        article: '5',
        image: 'assets/goods/3.jpg',
        price: '250 ₽'),
    GoodsModel(
        title: 'День игры с 14:00 до 22:00',
        article: 'day',
        image: 'assets/goods/4.jpg',
        price: '550 ₽'),
    GoodsModel(
        title: 'Ночь игры с 22:00 до 06:00',
        article: 'night',
        image: 'assets/goods/5.jpg',
        price: '400 ₽'),
    GoodsModel(
        title: 'Целый день игры в клубе (с 14:00 до 06:00)',
        article: 'full',
        image: 'assets/goods/6.jpg',
        price: '800 ₽'),
    GoodsModel(
        title: 'Пакет 50 часов на 30 дней',
        article: '50',
        image: 'assets/goods/7.jpg',
        price: '4000 ₽'),
    GoodsModel(
        title: 'Пакет 100 часов на 30 дней',
        article: '50',
        image: 'assets/goods/8.jpg',
        price: '7000 ₽'),
    GoodsModel(
        title: 'Пакет 150 часов на 30 дней',
        article: '150',
        image: 'assets/goods/9.jpg',
        price: '10000 ₽'),
    GoodsModel(
        title: 'Час игры в виртуальной реальности',
        article: 'vr',
        image: 'assets/goods/10.jpg',
        price: '200 ₽'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _goodsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 220,
                  width: 215,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      scale: 1.0,
                      fit: BoxFit.fill,
                      image: AssetImage(_goodsList[index].image),
                    ),
                  ),
                ),
                Container(
                    width: 180,
                    child: Text(
                      _goodsList[index].title,
                      maxLines: 3,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          );
        });
  }
}
