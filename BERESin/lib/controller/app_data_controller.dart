import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDataController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get StreamAuthStatus => auth.authStateChanges();

  void login(String email, String password) async {
    try {
   UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
  }
  void signup() {}
  void logout() {}

}
