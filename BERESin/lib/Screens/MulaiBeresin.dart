import 'dart:typed_data';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Menu/menu_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/post.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_auth/utils.dart';
import 'package:flutter_auth/resources/image_store_methods.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;




class Beresin extends StatefulWidget {
  const Beresin({super.key});

  @override
 State<Beresin> createState() => _BERESinState();
}

String sanitizeEmail(String email) {
  return email.replaceAll('.', '_'); // Replace dots with underscores
}

class _BERESinState extends State<Beresin> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Position? _currentPosition;
  double targetLatitude = -7.534541782626082;
  double targetLongtitude = 112.55997957167662;
  double radiusInMeters = 200;
  bool isWithinRadius = false;
  bool isUploading = false; // Flag to show progress bar
  double uploadProgress = 0.0; // Progress of the upload (0.0 to 1.0)

   Uint8List? _file;
  Uint8List? _file2;
  final TextEditingController _descriptionController = TextEditingController();

  // Initialize Cloudinary with your credentials
  final cloudinary = Cloudinary.full(
    apiKey: '799984246913394',
    apiSecret: 'A3Cj502Y9pfcjXr3qU-DK_-6Rro',
    cloudName: 'dce4zulnm',
  );

Future<String> uploadToCloudinary(Uint8List file) async {
  const cloudinaryUrl = 'https://api.cloudinary.com/v1_1/dce4zulnm/image/upload';
  const uploadPreset = 'file_upload';

  var request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
    ..fields['upload_preset'] = uploadPreset
    ..files.add(
      http.MultipartFile.fromBytes(
        'file',
        file,
        filename: 'image.jpg', // Provide a filename
      ),
    );

  var response = await request.send();
  if (response.statusCode == 200) {
    var responseData = await http.Response.fromStream(response);
    var jsonResponse = jsonDecode(responseData.body);
    return jsonResponse['secure_url'];
  } else {
    throw Exception('Failed to upload image: ${response.statusCode}');
  }
}

  Future<bool> _checkLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      _currentPosition = position;

  double distance = Geolocator.distanceBetween(
    _currentPosition!.latitude,
    _currentPosition!.longitude,
    targetLatitude,
    targetLongtitude,
  );

      isWithinRadius = distance <= radiusInMeters; // Update the boolean variable
      return isWithinRadius;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
  
 Future<String> storeAddressInFirebase(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];

    String address = '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
    return address;
  } catch (e) {
    print('Error: $e');
    return 'Address not found';
  }
}

Future<void> someFunction() async {
  // This function is marked as async
  if (_currentPosition != null) {
    String address = await storeAddressInFirebase(_currentPosition!.latitude, _currentPosition!.longitude);
    // Use the address as needed
  }
}







  void clearImage(){
    setState(() {
      _file = null;
      _file2=null;
    });
  }

 _imageSelect(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Select Image'),
            children: [

              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Take a Photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  Uint8List file2 = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                    _file2 = file2;
                  });
                },
              ),

              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
       });
      }

String _formattedTime = "";
String _formattedDate = "";


@override
void initState() {
  super.initState();
  _updateTime();
  _checkLocation().then((value) {
    setState(() {
      isWithinRadius = value; // Update the state after checking location
    });
  });

  // Get the current logged-in user's email and pass it to _submitData
  final user = FirebaseAuth.instance.currentUser;
  if (user != null && user.email != null) {
    _submitData(user.email!); // Pass the user's email to _submitData
  } else {
    print('User not logged in or email not available');
  }
}


Future<void> _storeAddress() async {
    // Ensure that _currentPosition is set before calling the method
    if (_currentPosition != null) {
      String address = await storeAddressInFirebase(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      // You can use the address here if needed
      print('Address: $address');
    } else {
      print('Current position is not available.');
    }
  }

void _updateTime(){
  DateTime now = DateTime.now();
  setState(() {
    _formattedTime ="${now.hour}:${now.minute}:${now.second}";
    _formattedDate = "${now.year}-${now.month}-${now.day}";
  });
}

Future<String> Lokasi() async {
  // Check if the location is within the radius
  bool isWithin = await _checkLocation();
  return isWithin ? 'di dalam' : 'di luar';
}


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
                  "Mulai BERESin !",
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
        body: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: ListView(children: [
              const Text(
                'Haloo !',
                style: TextStyle(fontSize: 14, fontFamily: "Kanit"),
              ),
              const Text(
                'waktu adalah uang, selamat bekerja',
                style: TextStyle(fontSize: 12, fontFamily: "Kanit italic"),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Colors.grey[300],
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15,
                          spreadRadius: 1.0),
                    ]),
                child: ListTile(
                  title: Text(
                    "$_formattedDate",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Kanit",
                      color: Colors.black54,
                    ),
                  ),

                  // subtitle: const Text('dataaaaaa'),

                  leading: const Icon(Icons.calendar_month_outlined, size: 30),
                  minLeadingWidth: 20,
                  minTileHeight: 50,
                  // contentPadding: EdgeInsets.all(20),
                  // dense: true,
                  iconColor: kPrimaryColor,
                  tileColor: Colors.grey[200],
                  hoverColor: const Color.fromARGB(184, 192, 244, 194),
                  onTap: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Colors.grey[300],
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15,
                          spreadRadius: 1.0),
                    ]),
                child: ListTile(
                  title: Text(
                    "$_formattedTime",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Kanit",
                      color: Colors.black54,
                    ),
                  ),

                  // subtitle: const Text('dataaaaaa'),

                  leading: const Icon(Icons.alarm_outlined, size: 30),
                  minLeadingWidth: 20,
                  minTileHeight: 50,
                  // contentPadding: EdgeInsets.all(20),
                  // dense: true,
                  iconColor: kPrimaryColor,
                  tileColor: Colors.grey[200],
                  hoverColor: const Color.fromARGB(184, 192, 244, 194),
                  onTap: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Colors.grey[300],
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15,
                          spreadRadius: 1.0),
                    ]),
                child: ListTile(
              title: FutureBuilder<String>(
                future: Lokasi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Memeriksa lokasi...");
                  } else if (snapshot.hasError) {
                    return const Text("Error!");
                  } else {
                    return Text(
                      snapshot.data ?? 'Unknown',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Kanit",
                        color: Colors.black54,
                      ),
                    );
                  }
                },
              ),
              leading: const Icon(Icons.location_on_outlined, size: 30), // Outlined location icon
              minLeadingWidth: 20,
              minTileHeight: 50,
              iconColor: kPrimaryColor,
              tileColor: Colors.grey[200],
              hoverColor: const Color.fromARGB(255, 134, 176, 93),
              onTap: () {
                // Handle tap if needed
              },
            ),
          ),
      // subtitle: const Text('dataaaaaa')
             _file == null ?
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround, // Space between the columns
          children: [
            // Left Column
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center items vertically in this column
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    iconSize: 30,
                    color: kPrimaryColor,
                    hoverColor: const Color.fromARGB(184, 192, 244, 194),
                    onPressed: () => _imageSelect(context),
                  ),
                  const Text(
                    'Foto Sebelum',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),

            // Right Column (Top Center)
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Align items at the top
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    iconSize: 30,
                    color: kPrimaryColor,
                    hoverColor: const Color.fromARGB(184, 192, 244, 194),
                    onPressed: () => _imageSelect(context),
                  ),
                  const Text(
                    'Foto Sesudah',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        )

                    :
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.centerLeft,
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(width: 0), // Adjust the width as needed
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(_file2!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.centerLeft,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 50),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
              onPressed: isWithinRadius
                  ? () async {
                      // Get the current logged-in user's email
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null && user.email != null) {
                        // Pass the user's email to _submitData
                        await _submitData(user.email!); // The await keyword ensures that the function completes before proceeding.
                      } else {
                        // Handle the case where the user is not logged in or the email is null
                        print('User not logged in or email not available');
                      }
                    }
                  : null, // Disable the button if not within the radius
              child: const Text("SEMANGAT!"),
            ),

              isUploading ? 
              Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Uploading: ${ (uploadProgress * 100).toStringAsFixed(0)}%'),
                ],
              ),
            )
          : Container(),
              ]),
            ])));
        
  }

  // _submitData method with upload progress
  Future<void> _submitData(String userEmail) async {
    try {
      if (_file == null || _file2 == null) {
        throw Exception("Images not selected");
      }

      setState(() {
        isUploading = true; // Show progress bar
        uploadProgress = 0.0; // Reset progress
      });

      // Upload images to Cloudinary
      String photoUrl1 = await uploadToCloudinary(_file!);
      setState(() {
        uploadProgress = 0.5; // Update progress after first upload
      });

      String photoUrl2 = await uploadToCloudinary(_file2!);
      setState(() {
        uploadProgress = 1.0; // Update progress to 100% after second upload
      });

      // Get current time and address
      DateTime now = DateTime.now();
      String formattedDate = "${now.day}-${now.month}-${now.year}";
      String formattedTime = "${now.hour}:${now.minute}:${now.second}";

      String address = '';
      if (_currentPosition != null) {
        address = await storeAddressInFirebase(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        );
      }

      // Sanitize email for Firestore collection ID
      String sanitizedEmail = sanitizeEmail(userEmail);

      // Save all data to Firestore with email as collection ID and date as document ID
      await _firestore
          .collection(sanitizedEmail) // Collection named after sanitized email
          .doc(formattedDate) // Document named after the current date
          .set({
        'Date': formattedDate,
        'Time': formattedTime,
        'address': address,
        'timestamp': FieldValue.serverTimestamp(),
        'image1': photoUrl1,
        'image2': photoUrl2,
      });

      // Show success alert and navigate to the menu
      if (context.mounted) {
        setState(() {
          isUploading = false; // Hide progress bar when done
        });

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Success"),
              content: const Text("Data has been successfully uploaded!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MenuScreen(),
                      ),
                    );
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      setState(() {
        isUploading = false; // Hide progress bar on error
      });
      showSnackBar('Error: $e', context);
    }
  }
}