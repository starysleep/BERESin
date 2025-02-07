import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/jadwal/Jadwal.dart';
import 'package:flutter_auth/Screens/Menu/menu_form.dart';
import 'package:flutter_auth/Screens/MulaiBeresin.dart';
import 'package:flutter_auth/Screens/Beres.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

@override
State<MenuScreen> createState() => _MenuScreenState();
}

 class _MenuScreenState extends State<MenuScreen>{

  final user=FirebaseAuth.instance.currentUser;

  signout()async{
      await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          toolbarHeight: 175,
          title: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "BERESin !",
                style: TextStyle(
                  shadows: [
                    Shadow(
                        color: Color.fromARGB(147, 75, 66, 66),
                        blurRadius: 3,
                        offset: Offset(2, 3))
                  ],
                  color: Color.fromARGB(255, 247, 231, 212),
                  // fontWeight: FontWeight.bold,
                  fontSize: 34,
                  fontFamily: "IrishGrover",
                ),
              ),
              Text(
                'Absen dari genggaman',
                style: TextStyle(
                  shadows: [
                    Shadow(
                        color: Color.fromARGB(147, 75, 66, 66),
                        blurRadius: 3,
                        offset: Offset(2, 3))
                  ],
                  fontSize: 16,
                  color: Color.fromARGB(255, 247, 231, 212),
                  fontFamily: "MarkaziText",
                ),
              ),
            ],
          ),
          centerTitle: true,
          flexibleSpace: Container(
              decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28)),
            color: Color.fromARGB(255, 134, 176, 93),
          ))),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 20.0),
        child: ListView(
          children: [
            const Text(
              'Selamat datang!',
              style: TextStyle(fontSize: 14, fontFamily: "Kanit"),
            ),
            const Text(
              'Hari ini anda piket, Selamat bekerja!',
              style: TextStyle(fontSize: 12, fontFamily: "Kanit italic"),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 134, 176, 93),
                      width: 1.5),
                  borderRadius: BorderRadius.circular(70),
                  color: Colors.grey[300],
                  boxShadow: const [
                    // BoxShadow(
                    //     color: Colors.grey.shade500,
                    //     offset: const Offset(4.0, 4.0),
                    //     blurRadius: 15,
                    //     spreadRadius: 1.0),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 15,
                        spreadRadius: 1.0),
                  ]),
              child: ListTile(
                title: const Text(
                  'Jadwal Piket',
                  style: TextStyle(fontSize: 16, fontFamily: "Kanit"),
                ),

                // subtitle: const Text('dataaaaaa'),
                trailing: const Icon(Icons.arrow_forward_ios),
                leading:
                    const Icon(Icons.playlist_add_check_outlined, size: 30),
                minLeadingWidth: 20,
                minTileHeight: 50,
                // contentPadding: EdgeInsets.all(20),
                // dense: true,
                tileColor: const Color.fromARGB(185, 0, 0, 0),
                hoverColor: const Color.fromARGB(184, 192, 244, 194),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const JadwalPiket()),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 134, 176, 93),
                      width: 1.5),
                  borderRadius: BorderRadius.circular(70),
                  color: Colors.grey[300],
                  boxShadow: const [
                    // BoxShadow(
                    //     color: Colors.grey.shade500,
                    //     offset: const Offset(4.0, 4.0),
                    //     blurRadius: 15,
                    //     spreadRadius: 1.0),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 15,
                        spreadRadius: 1.0),
                  ]),
              child: ListTile(
                title: const Text(
                  'Mulai BERESin',
                  style: TextStyle(fontSize: 16, fontFamily: "Kanit"),
                ),

                // subtitle: const Text('dataaaaaa'),
                trailing: const Icon(Icons.arrow_forward_ios),
                leading: const Icon(Icons.clean_hands_outlined, size: 30),
                minLeadingWidth: 20,
                minTileHeight: 50,
                // contentPadding: EdgeInsets.all(20),
                // dense: true,
                tileColor: const Color.fromARGB(185, 0, 0, 0),
                hoverColor: const Color.fromARGB(184, 192, 244, 194),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Beresin()),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 134, 176, 93),
                      width: 1.5),
                  borderRadius: BorderRadius.circular(70),
                  color: Colors.grey[300],
                  boxShadow: const [
                    // BoxShadow(
                    //     color: Colors.grey.shade500,
                    //     offset: const Offset(4.0, 4.0),
                    //     blurRadius: 15,
                    //     spreadRadius: 1.0),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 15,
                        spreadRadius: 1.0),
                  ]),
              child: ListTile(
                title: const Text(
                  'Laporan',
                  style: TextStyle(fontSize: 16, fontFamily: "Kanit"),
                ),
                // subtitle: const Text('dataaaaaa'),
                trailing: const Icon(Icons.arrow_forward_ios),
                leading: const Icon(Icons.assignment_outlined, size: 30),
                minLeadingWidth: 20,
                minTileHeight: 50,
                // contentPadding: EdgeInsets.all(50),
                // dense: true,
                tileColor: const Color.fromARGB(185, 0, 0, 0),
                hoverColor: const Color.fromARGB(184, 192, 244, 194),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryScreen()),
                  );
                },
              ),
            ),
             FloatingActionButton(
                  onPressed: (()=>signout()),
                  child: Icon(Icons.login_rounded))
          ],
        ),
      ),
    );
    
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: MenuForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
