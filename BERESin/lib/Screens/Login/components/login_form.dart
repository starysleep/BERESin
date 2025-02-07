import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
// import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

  class _LoginFormState extends State<LoginForm>{

    TextEditingController email=TextEditingController();
    TextEditingController password=TextEditingController();

    signIn()async{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
    }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            controller: email,
            decoration: const InputDecoration(
              hintText: "Your Email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              controller: password,
              decoration: const InputDecoration(
                hintText: "Your Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock_person_rounded),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: (()=>signIn()),
            child: Text(
              "Login".toUpperCase(),
              style: const TextStyle(fontSize: 16, fontFamily: "Kanit"),
            ),
          ),
          // const SizedBox(height: defaultPadding),
          // AlreadyHaveAnAccountCheck(
          //   press: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return const SignUpScreen();
          //         },
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
