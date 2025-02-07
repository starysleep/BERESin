import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String? sanitizedEmail = user != null ? sanitizeEmail(user.email!) : null;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 175,
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // Remove the shadow
        title: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "BERES !",
              style: TextStyle(
                shadows: [
                  Shadow(
                    color: Color.fromARGB(147, 75, 66, 66),
                    blurRadius: 3,
                    offset: Offset(2, 3),
                  ),
                ],
                color: Color.fromARGB(255, 247, 231, 212),
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
            color: Color.fromARGB(255, 134, 176, 93), // Green background
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70),
          color: Colors.grey[300],
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: sanitizedEmail != null
                  ? StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(sanitizedEmail)
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text("Error: ${snapshot.error}"));
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text("No history found."));
                        }

                        final documents = snapshot.data!.docs;

                        return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            final data = documents[index].data() as Map<String, dynamic>;
                            return Card(
                              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 4.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (data['image1'] != null || data['image2'] != null)
                                    Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                                        color: Colors.grey[200],
                                      ),
                                      child: PageView(
                                        children: [
                                          if (data['image1'] != null)
                                            _cachedImageWithLoader(data['image1']),
                                          if (data['image2'] != null)
                                            _cachedImageWithLoader(data['image2']),
                                        ],
                                      ),
                                    ),
                                  // Footer with details
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                                    color: Color.fromARGB(255, 134, 176, 93),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        _infoColumn(Icons.access_time, "Time", data['Time'] ?? "N/A"),
                                        _infoColumn(Icons.calendar_today, "Date", data['Date'] ?? "N/A"),
                                        _infoColumn(Icons.location_on, "Location", "Di dalam sekolah"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )
                  : const Center(child: Text("User not logged in.")),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cachedImageWithLoader(String imageUrl) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.error, color: Colors.red, size: 50),
        ),
      ),
    );
  }

  Widget _infoColumn(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(height: 4),
        Text(
          "$label\n$value",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  String sanitizeEmail(String email) {
    return email.replaceAll('.', '_'); // Replace dots with underscores
  }
}
