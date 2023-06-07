import 'package:etime_application/main.dart';
import 'package:etime_application/models/order_model.dart';
import 'package:etime_application/models/profile_model.dart';
import 'package:etime_application/screens/BonusesCardScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CardWidget extends StatefulWidget {
  final ProfileModel user;
  const CardWidget({super.key, required this.user});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  List<Order> _wallet = [
    new Order(
        name: "Fresh Mutton",
        amount: "15.08",
        datetime: "12:03 | 24.02.2021",
        orderId: "#51602",
        orderOption: "Re - order",
        orderStatus: "Delivered"),
    new Order(
        name: "Fresh Chicken",
        amount: "11.08",
        datetime: "10:57 | 25.02.2021",
        orderId: "#202145",
        orderOption: "Cancel",
        orderStatus: "Scheduled"),
    new Order(
        name: "Fresh Lamb",
        amount: "12.08",
        datetime: "12:03 | 24.02.2021",
        orderId: "#202145",
        orderOption: "Track Order",
        orderStatus: "Ongoing"),
    new Order(
        name: "Fresh Mutton",
        amount: "15.08",
        datetime: "11:36 | 27.02.2021",
        orderId: "#412563",
        orderOption: "Re - order",
        orderStatus: "Cancelled"),
    new Order(
        name: "Fresh Chicken",
        amount: "11.08",
        datetime: "12:03 | 26.02.2021",
        orderId: "#202145",
        orderOption: "Cancel",
        orderStatus: "Scheduled"),
    new Order(
        name: "Fresh Lamb",
        amount: "12.08",
        datetime: "12:03 | 28.02.2021",
        orderId: "#412563",
        orderOption: "Re - order",
        orderStatus: "Ongoing"),
    new Order(
        name: "Fresh Mutton",
        amount: "15.08",
        datetime: "12:03 | 24.02.2021",
        orderId: "#51602",
        orderOption: "Re - order",
        orderStatus: "Delivered"),
    new Order(
        name: "Fresh Chicken",
        amount: "11.08",
        datetime: "10:57 | 25.02.2021",
        orderId: "#202145",
        orderOption: "Cancel",
        orderStatus: "Scheduled"),
    new Order(
        name: "Fresh Lamb",
        amount: "12.08",
        datetime: "12:03 | 24.02.2021",
        orderId: "#202145",
        orderOption: "Track Order",
        orderStatus: "Ongoing"),
    new Order(
        name: "Fresh Mutton",
        amount: "15.08",
        datetime: "11:36 | 27.02.2021",
        orderId: "#412563",
        orderOption: "Re - order",
        orderStatus: "Cancelled"),
    new Order(
        name: "Fresh Chicken",
        amount: "11.08",
        datetime: "12:03 | 26.02.2021",
        orderId: "#202145",
        orderOption: "Cancel",
        orderStatus: "Scheduled"),
    new Order(
        name: "Fresh Lamb",
        amount: "12.08",
        datetime: "12:03 | 28.02.2021",
        orderId: "#412563",
        orderOption: "Re - order",
        orderStatus: "Ongoing"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null!;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 10, 13, 66),
            centerTitle: true,
            title: Text('Бонусная карта'),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            actions: [
              PopupMenuButton(
                  // add icon, by default "3 dot" icon
                  // icon: Icon(Icons.book)
                  itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("Выйти"),
                  ),
                ];
              }, onSelected: (value) async {
                if (value == 0) {
                  print("My account menu is selected.");
                  await FirebaseAuth.instance.signOut();
                  BonusesCardScreenState.currentUser = ProfileModel(uid: '');
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Вы вышли из уч.записи')));
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'tabNavigator', (route) => false);
                }
              }),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromARGB(255, 10, 13, 66)),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage("assets/logo/applogo.png")
                                        as ImageProvider,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                        width: 45,
                                        height: 48,
                                        child: const Image(
                                          image: Svg('assets/svg/card.svg',
                                              color: Colors.grey),
                                          width: 70,
                                          height: 70,
                                        )),
                                    Card(
                                        elevation: 0,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                topLeft: Radius.circular(5),
                                                bottomLeft: Radius.circular(5),
                                                bottomRight:
                                                    Radius.circular(5))),
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0.0, left: 0.0, right: 20.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Бонусов: 120',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.white24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  MdiIcons.accountOutline,
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                  size: 30,
                                ),
                              ),
                              Text(
                                widget.user.name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                          Text(
                            'Скидка: 10%',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 100,
                        width: 350,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/barcode.jpg"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text('История операций',
                    style: TextStyle(
                        color: Color.fromARGB(255, 10, 13, 66),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Expanded(
                  child: _rechargeHistoryWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _rechargeHistoryWidget() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _wallet.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color.fromARGB(255, 10, 13, 66),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 8.0, left: 6.0, bottom: 8.0),
                      child: Container(
                        //color: Color.fromARGB(255, 10, 13, 66),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: Colors.white),
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              child: Text(
                                'BOOTCAMP',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 10, 13, 66)),
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Icon(
                              MdiIcons.checkDecagram,
                              size: 20,
                              color: Colors.greenAccent,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                'Успешно',
                                style: TextStyle(color: Colors.greenAccent),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _wallet[index].datetime,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "10 баллов",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
