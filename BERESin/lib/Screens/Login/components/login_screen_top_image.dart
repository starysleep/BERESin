import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class LoginScreenTopImage extends StatefulWidget {
   const LoginScreenTopImage({super.key});

   @override
  State<LoginScreenTopImage> createState() => _LoginScreenTopImageState();
}

  class _LoginScreenTopImageState extends State<LoginScreenTopImage>{


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset("assets/icons/Delivery.svg"),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
