/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Timestamp extends StatefulWidget {
  const Timestamp({super.key});

  @override
  State<Timestamp> createState() => _TimestampState();
}

class _TimestampState extends State<Timestamp> {
  @override
   void initState() {
   super.initState();
   sendDataToFirebase();
 }

void sendDataToFirestore() async {
  FirebaseFirestore.instance
    .collection('data')
    .add({'timestamp': FieldValue.serverTimestamp()});
}

var _numberToMonthMap = {
  1: "Jan",
  2: "Feb",
  3: "Mar",
  4: "Apr",
  5: "May",
  6: "Jun",
  7: "Jul",
  8: "Aug",
  9: "Sep",
  10: "Oct",
  11: "Nov",
  12: "Dec"

};  
@override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
    )
  body: FirestoreListView(
  query: FirebaseFirestore.instance
                    .collection('data')
                    .orderBy('timestamp', descending: true),
  loadingBuilder: (_) => CircularProgressIndicator(),
  itemBuilder: (context, snapshot) {
     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
     Timestamp t = data['timestamp'] as Timestamp;
     DateTime date = t.toDate();
                }, 
              )
           );
         }
  }
*/