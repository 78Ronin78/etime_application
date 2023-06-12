import 'package:etime_application/repository/save_values_to_local_base.dart';
import 'package:etime_application/screens/EventDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:etime_application/models/global.dart' as global;

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 10, 13, 66),
          centerTitle: true,
          title: Text('События'),
        ),
        body: Column(
          children: [
            Expanded(
              child: global.notificationList.isEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            //color: Colors.black,
                            height: MediaQuery.of(context).size.height - 150,
                            child: Center(
                              child: Text('Уведомлений нет',
                                  style: TextStyle(color: Colors.black)),
                            )),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        itemCount: global.notificationList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[200]!,
                                    blurRadius: 10.0, // soften the shadow
                                    spreadRadius: 1.0, //extend the shadow
                                    offset: Offset(
                                      5.0, // Move to right 10  horizontally
                                      5.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    global.notificationList[index].isRead =
                                        true;
                                    saveNotificationItemsToLocalBase(
                                        global.notificationList);
                                  });

                                  print(
                                      'Нажатое уведомление: ${global.notificationList[index].isRead}');

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EventDetailScreen(
                                            notification:
                                                global.notificationList[index],
                                          )));
                                },
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                global.notificationList[index]
                                                            .isRead ==
                                                        false
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(90),
                                                          child: Container(
                                                              height: 10,
                                                              width: 10,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      249,
                                                                      22,
                                                                      112)),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 8.0),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(90),
                                                          child: Container(
                                                              height: 10,
                                                              width: 10,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.35,
                                                  child: Text(
                                                    global
                                                        .notificationList[index]
                                                        .title!,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 10, 13, 66),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 19),
                                                    softWrap: true,
                                                    maxLines: 3,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 19.0, top: 3.0),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.36,
                                                    child: Text(
                                                      "${global.notificationList[index].description}",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),

                                                      //softWrap: true,
                                                      //maxLines: 2,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
