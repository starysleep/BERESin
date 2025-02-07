import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/wrapper.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Wrapper();
                },
              ),
            );
          },
          child: Text(
            "Login".toUpperCase(),
            style: const TextStyle(fontSize: 16, fontFamily: "Kanit"),
          ),
        ),
        const SizedBox(height: 16),
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) {
        //           return const SignUpScreen();
        //         },
        //       ),
        //     );
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: kPrimaryLightColor,
        //     elevation: 0,
        //   ),
        //   child: Text(
        //     "Sign Up".toUpperCase(),
        //     style: const TextStyle(color: Colors.black),
        //   ),
        // ),
      ],
    );
  }
}
