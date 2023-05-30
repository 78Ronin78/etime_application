import 'package:etime_application/widgets/GoodsCarouselWidget.dart';
import 'package:etime_application/widgets/ServicesCarouselWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(
            255, 10, 13, 66), //Заменяет цвет Статусбара при запуске приложения
        statusBarIconBrightness: Brightness.light));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              toolbarHeight: 100,
              title: Text(
                'BOOTCAMP',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3,
              ),
              centerTitle: true,
              backgroundColor: Color.fromARGB(255, 10, 13, 66),
              automaticallyImplyLeading: false,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/main_banner.jpg'),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Услуги',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color.fromARGB(255, 249, 22, 112),
                      ),
                    ),
                  ),
                  Container(height: 160, child: ServicesCarouselWidget()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Товары',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color.fromARGB(255, 249, 22, 112)),
                    ),
                  ),
                  Container(height: 650, child: GoodsCarouselWidget()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
