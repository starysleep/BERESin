import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "BERESin",
          style: TextStyle(
            shadows: [
              Shadow(
                  color: Color.fromARGB(150, 133, 131, 131),
                  blurRadius: 2,
                  offset: Offset(2, 5))
            ],
            color: Color.fromARGB(255, 247, 231, 212),
            // fontWeight: FontWeight.bold,
            fontSize: 40,
            fontFamily: "IrishGrover",
          ),
        ),
        const Text(
          "Absen dari genggaman",
          style: TextStyle(
              shadows: [
                Shadow(
                    color: Color.fromARGB(150, 133, 131, 131),
                    blurRadius: 2,
                    offset: Offset(2, 5))
              ],
              color: Color.fromARGB(255, 247, 231, 212),
              fontSize: 12,
              fontFamily: "MarkaziText"),
        ),
        // const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 10,
              child: SvgPicture.asset(
                "assets/icons/icon1.svg",
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
