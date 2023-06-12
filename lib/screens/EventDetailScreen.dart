import 'package:etime_application/models/notification_model.dart';
import 'package:flutter/material.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({required this.notification, super.key});
  final NotificationModel notification;
  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 13, 66),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          widget.notification.title!,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.notification.title!,
                    style: TextStyle(
                        color: Color.fromARGB(255, 10, 13, 66),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    //softWrap: true,
                    //maxLines: 2,
                  ),
                  Text(
                    widget.notification.description!,
                    style: TextStyle(
                      color: Color.fromARGB(255, 10, 13, 66),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
