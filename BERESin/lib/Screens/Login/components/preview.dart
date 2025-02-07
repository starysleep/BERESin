/*
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/preview2.dart';
import 'package:flutter_auth/Screens/Menu/menu_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/constants.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _Preview();
}

class _Preview extends State<Preview> {

  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser ;
    String? sanitizedEmail = user != null ? sanitizeEmail(user.email!) : null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 350,
            child: PageView.builder(
              controller: pageController,
              itemCount: Images.length,
              onPageChanged: (value) => setState(() {
                currentIndex = value;
              }),
              itemBuilder: (context, index) => Image.asset(
                Images[index],
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            if (data['image1'] != null)
            Column(
            children: [
              Image.network,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 4),
                width: index == currentIndex ? 23 : 13,
                height: 13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: index == currentIndex
                      ? Colors.white
                      : const Color.fromARGB(255, 134, 176, 93),
                ),
              ),
        ],
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                text: "WELL DONE !",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ])),
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                text: "I know you have worked hard.",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ])),
          ),
          const SizedBox(height: 100),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 60),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Color.fromARGB(255, 134, 176, 93),
            ),
            child: FutureBuilder<DocumentSnapshot>(
              future: sanitizedEmail != null
                  ? FirebaseFirestore.instance
                      .collection(sanitizedEmail)
                      .orderBy('timestamp', descending: true)
                      .limit(1) // Get the latest submission
                      .get()
                      .then((snapshot) => snapshot.docs.isNotEmpty
                          ? snapshot.docs.first
                          : null)
                  : Future.value(null),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text("No data found."));
                }

                final data = snapshot.data!.data() as Map<String, dynamic>;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        preview2(
                          ikon: Icons.access_time,
                          property: "Time",
                          value: data['Time'],
                        ),
                          preview2(
                          ikon: Icons.date_range_outlined,
                          property: "Date",
                          value: data['Date'],
                        ),
                        preview2(
                          ikon: Icons.location_on_outlined,
                          property: "Location",
                          value: data['address'],
                        )
                      ],
                    )
                  ],
                );
              }
             )
          )
        ])),
      );
     }
      String sanitizeEmail(String email) {
    return email.replaceAll('.', '_'); // Replace dots with underscores
  }
}
*/