import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:etime_application/screens/BonusesCardScreen.dart';
import 'package:etime_application/screens/ContactsScreen.dart';
import 'package:etime_application/screens/EventsScreen.dart';
import 'package:etime_application/screens/GalleryScreen.dart';
import 'package:etime_application/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  //1 Создаем переменную для хранения индексной страницы
  var _bottomNavIndex = 0;

  //2 Создаем функцию списка с типом Widget, потому что в этом списке будут храниться виджеты других экранов навигации
  List<Widget> _screens() =>
      [HomeScreen(), ContactsScreen(), GalleryScreen(), EventsScreen()];

  //3 Создаем список иконок
  //Список иконок может состоять из набора иконок встроенной библиотеки Icons или CupertinoIcons
  List<IconData> _iconDataList = [
    Icons.home,
    Icons.contact_phone,
    Icons.image,
    Icons.event
  ];

  List<String> _menuTitle = ['Главная', 'Контакты', 'Галерея', 'События'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        //задаем параметр количества иконок, ссылаясь на наш список _iconDataList или _iconImageDataList
        itemCount: _iconDataList.length,
        //задаем активную вкладку
        activeIndex: _bottomNavIndex,
        //задаем обязательный параметр onTap для обработки событий нажатия на вкладку
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //строим вкладки tabbuilder
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _iconDataList[index],
                //здесь меняется цвет иконок нижнего меню
                color: Colors.deepPurple[900],
                size: 30.0,
              ),
              //ImageIcon(_iconImageData[index].image),
              const SizedBox(height: 5),
              isActive
                  ? Container(
                      height: 2,
                      width: 15,
                      color: Colors.deepPurple[900],
                    )
                  : SizedBox(),
              Text(_menuTitle[index],
                  style: TextStyle(
                      color:
                          isActive ? Colors.deepPurple[900] : Colors.grey[500],
                      fontSize: 10)),
            ],
          );
        },
        //Фоновый цвет панели нижней навигации
        backgroundColor: Colors.white,
        //определяем положение плавающей иконки и распределение иконок равномерно по центру
        gapLocation: GapLocation.center,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.deepPurple[900],
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => BonusesCardScreen()));
        },
        child: Icon(
          Icons.card_giftcard,
          color: Colors.white,
          size: 35,
        ),
      ),
      //Задаем отображение виджетов экранов в тело bottomNavigationBar
      body: _screens().elementAt(_bottomNavIndex),
    );
  }
}
