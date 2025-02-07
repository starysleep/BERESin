// permissions_handler.dart
import 'package:permission_handler/permission_handler.dart';

class PermissionsHandler {
  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isGranted) {
      return true; // Permission is already granted
    } else if (status.isDenied) {
      // Request permission
      var result = await Permission.location.request();
      return result.isGranted; // Return whether permission was granted or not
    } else if (status.isPermanentlyDenied) {
      // Optionally, you can open app settings
      openAppSettings();
      return false; // Permission is permanently denied
    }
    return false; // For any other case
  }
}