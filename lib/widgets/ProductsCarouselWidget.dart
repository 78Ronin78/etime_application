import 'package:etime_application/models/produtcs_model.dart';
import 'package:etime_application/screens/ProductDetailsScreen.dart';
import 'package:flutter/material.dart';

class ProductsCarouselWidget extends StatefulWidget {
  const ProductsCarouselWidget({super.key});

  @override
  State<ProductsCarouselWidget> createState() => _ProductsCarouselWidgetState();
}

class _ProductsCarouselWidgetState extends State<ProductsCarouselWidget> {
  List<ProductsModel> _productsList = [
    ProductsModel(
        title: 'Час игры',
        article: '1',
        image: 'assets/goods/1.jpg',
        description:
            '\n 🔵 Час игры в нашем компьютерном клубе. \n На выбор три категории комнат с разной конфигурацией компьютеров (GAMING, VIP или STRIM). \n \n Понедельник — четверг: \n 🔵 1 час GAMING — 110 рублей \n 🔵 1 час VIP — 130 рублей \n 🔵 1 час STRIM — 150 рублей \n \n Пятница — воскресенье: \n 🔵 1 час GAMING — 130 рублей \n 🔵 1 час VIP — 150 рублей \n 🔵 1 час STRIM — 170 рублей',
        price: '110 ₽'),
    ProductsModel(
        title: 'Три часа игры',
        article: '3',
        image: 'assets/goods/2.jpg',
        description:
            '\n 🔵 Три часа игры в нашем компьютерном клубе. \n 🔵 На выбор три категории комнат с разной конфигурацией компьютеров (GAMING, VIP или STRIM). \n \n Понедельник — четверг: \n 🔵 3 часа GAMING — 250 рублей \n 🔵 3 часа VIP — 300 рублей \n 🔵 3 часа STRIM — 350 рублей \n \n Пятница — воскресенье: \n 🔵 3 часа GAMING — 300 рублей \n 🔵 3 часа VIP — 350 рублей \n 🔵 3 часа STRIM — 400 рублей',
        price: '250 ₽'),
    ProductsModel(
        title: 'Пять часов игры',
        article: '5',
        image: 'assets/goods/3.jpg',
        description:
            '\n 🔵 Пять часов игры в нашем компьютерном клубе. \n 🔵 На выбор три категории комнат с разной конфигурацией компьютеров (GAMING, VIP или STRIM). \n \n Понедельник — четверг: \n 🔵 5 часов GAMING — 400 рублей \n 🔵 5 часов VIP — 500 рублей \n 🔵 5 часов STRIM — 600 рублей \n \n Пятница — воскресенье: \n 🔵 5 часов GAMING — 500 рублей \n 🔵 5 часов VIP — 600 рублей \n 🔵 5 часов STRIM — 700 рублей',
        price: '250 ₽'),
    ProductsModel(
        title: 'День игры с 14:00 до 22:00',
        article: 'day',
        image: 'assets/goods/4.jpg',
        description:
            '\n 🔵 8 часов игры с 14:00 до 22:00 в нашем компьютерном клубе. \n 🔵 На выбор три категории комнат с разной конфигурацией компьютеров (GAMING, VIP или STRIM). \n \n Понедельник — четверг: \n 🔵 Ночь GAMING — 550 рублей \n 🔵 Ночь VIP — 700 рублей \n 🔵 Ночь STRIM — 850 рублей \n \n Пятница — воскресенье: \n 🔵 Ночь GAMING — 700 рублей \n 🔵 Ночь VIP — 850 рублей \n 🔵 Ночь STRIM — 1000 рублей',
        price: '550 ₽'),
    ProductsModel(
        title: 'Ночь игры с 22:00 до 06:00',
        article: 'night',
        image: 'assets/goods/5.jpg',
        description:
            '\n 🔵 Ночь игры с 22:00 вечера до 06:00 утра в нашем компьютерном клубе. \n 🔵 На выбор три категории комнат с разной конфигурацией компьютеров (GAMING, VIP или STRIM). \n \n  Понедельник — четверг: \n 🔵 Ночь GAMING — 400 рублей \n 🔵 Ночь VIP — 500 рублей \n 🔵 Ночь STRIM — 600 рублей \n \n Пятница — воскресенье: \n 🔵 Ночь GAMING — 500 рублей \n 🔵 Ночь VIP — 600 рублей \n 🔵 Ночь STRIM — 700 рублей',
        price: '400 ₽'),
    ProductsModel(
        title: 'Целый день игры в клубе (с 14:00 до 06:00)',
        article: 'full',
        image: 'assets/goods/6.jpg',
        description:
            '\n 🔵 Целый день игры в нашем клубе (с 14:00 до 06:00) \n 🔵 На выбор три категории комнат с разной конфигурацией компьютеров (GAMING, VIP или STRIM). \n \n Понедельник — четверг: \n 🔵 Зона GAMING — 800 ₽ \n 🔵 Зона VIP — 1000 ₽ \n 🔵 Зона STRIM — 1200 ₽ \n \n Пятница — воскресенье: \n 🔵 Зона GAMING — 1000 ₽ \n 🔵 Зона VIP — 1200 ₽ \n 🔵 Зона STRIM — 1400 ₽',
        price: '800 ₽'),
    ProductsModel(
        title: 'Пакет 50 часов на 30 дней',
        article: '50',
        image: 'assets/goods/7.jpg',
        description:
            '\n 🔵 Пакет 50 часов игры в нашем компьютерном клубе (действует 30 дней). \n 🔵 На выбор три категории комнат с разной конфигурацией компьютеров (GAMING, VIP или STRIM). \n \n 🔵 Зона Gaming — 4000 ₽ (по отдельности — 5000 ₽) \n 🔵 Зона VIP — 5000 ₽ (по отдельности — 6000 ₽) \n 🔵 Зона STRIM — 6000 ₽ (по отдельности — 6000 ₽)',
        price: '4000 ₽'),
    ProductsModel(
        title: 'Пакет 100 часов на 30 дней',
        article: '50',
        image: 'assets/goods/8.jpg',
        description:
            '\n 🔵 Пакет 100 часов игры в нашем компьютерном клубе (действует 30 дней). \n 🔵 На выбор три категории комнат с разной конфигурацией компьютеров (GAMING, VIP или STRIM). \n \n 🔵 Зона Gaming — 7000 ₽ (по отдельности — 10000 ₽) \n 🔵 Зона VIP — 9000 ₽ (по отдельности — 12000 ₽) \n 🔵 Зона STRIM — 11000 ₽ (по отдельности — 12000 ₽)',
        price: '7000 ₽'),
    ProductsModel(
        title: 'Пакет 150 часов на 30 дней',
        article: '150',
        image: 'assets/goods/9.jpg',
        description:
            '\n 🔵 Пакет 150 часов игры в нашем компьютерном клубе (действует 30 дней). \n 🔵 На выбор три категории комнат с разной конфигурацией компьютеров (GAMING, VIP или STRIM). \n \n 🔵 Зона Gaming — 10000 ₽ (по отдельности — 15000 ₽) \n 🔵 Зона VIP — 13000 ₽ (по отдельности — 18000 ₽) \n 🔵 Зона STRIM — 16000 ₽ (по отдельности — 18000 ₽)',
        price: '10000 ₽'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _productsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                          title: _productsList[index].title,
                          description: _productsList[index].description,
                          image: _productsList[index].image,
                          article: _productsList[index].article,
                          price: _productsList[index].price,
                        )));
              },
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
                        image: AssetImage(_productsList[index].image),
                      ),
                    ),
                  ),
                  Container(
                      width: 180,
                      child: Text(
                        _productsList[index].title,
                        maxLines: 3,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ),
          );
        });
  }
}
