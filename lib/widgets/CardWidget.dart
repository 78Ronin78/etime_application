import 'package:etime_application/models/profile_model.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final ProfileModel user;
  const CardWidget({super.key, required this.user});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
