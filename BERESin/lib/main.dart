import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'permissions_handler.dart';

void main() async{

  // This widget is the root of your application.
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
   const MyApp({super.key});

   @override
  State<MyApp> createState() => _MyAppState();
}

  class _MyAppState extends State<MyApp>{
  PermissionsHandler _permissionsHandler = PermissionsHandler();


   @override
    void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    bool granted = await _permissionsHandler.requestLocationPermission();
    
    if (granted) {
      // Permission granted, proceed with your logic
      print("Location permission granted.");
      // You can add your logic here to handle the case when permission is granted
    } else {
      // Permission denied, handle accordingly
      print("Location permission denied.");
      // You can add your logic here to handle the case when permission is denied
    }
  }

    @override
    Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BERESin',
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(134, 176, 93, 1),
          scaffoldBackgroundColor: const Color.fromARGB(255, 134, 176, 93),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              foregroundColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 247, 231, 212),
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: Color.fromARGB(255, 134, 176, 93),
            prefixIconColor: Color.fromARGB(255, 134, 176, 93),
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: WelcomeScreen(),
    );
  }
}
