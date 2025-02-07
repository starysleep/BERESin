import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

class Tinder extends StatelessWidget {
  final color;

  const Tinder({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Swipable(
        child: Container(
      color: color,
    ));
  }
}
