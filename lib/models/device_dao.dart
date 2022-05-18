
import 'package:firebase_database/firebase_database.dart';
import 'package:smart_home_demo/models/device.dart';

class DeviceDao {
  final DatabaseReference _deviceRef =
  FirebaseDatabase.instance.reference().child('device');

  void saveDevice(Device device) {
    _deviceRef.push().set(device.toJson());
  }

  Query getDeviceQuery() {
    return _deviceRef;
  }
}