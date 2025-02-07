
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

class preview2 extends StatelessWidget {
  final IconData ikon;
  final String property, value;
  const preview2({
    super.key,
    required this.ikon,
    required this.property,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          ikon,
          size: 30,
          color: Colors.white,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          property,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFFE0E0E0),
          ),
        ),
      ],
    );
  }
}