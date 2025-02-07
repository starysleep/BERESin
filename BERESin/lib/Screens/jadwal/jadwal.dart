import 'package:flutter/material.dart';

class JadwalPiket extends StatelessWidget {
  const JadwalPiket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            toolbarHeight: 175,
            backgroundColor: Colors.white,
            title: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Jadwal Piket !",
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
        body: Center(
            child: Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: ListView(children: [
                  const Text(
                    'Jadwal piket tkj 1 ',
                    style: TextStyle(fontSize: 14, fontFamily: "Kanit"),
                  ),
                  const Text(
                    'tetap jaga kebersihan yaa..',
                    style: TextStyle(fontSize: 12, fontFamily: "Kanit italic"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                    child: Image.asset(
                      "assets/images/jadwal2.png",
                      width: 300,
                      height: 300,
                    ),
                  )
                ]
                    // padding: const EdgeInsets.all(150),
                    ))));
  }
}
