import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'location_adapter.dart';

/*
this class has methods related to hive database that i am using to store
 users information locally
and also to store user live location locally in locations table
 */
class HiveHelper {
  static Future<void> init() async {
    try {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDir.path);
      Hive.registerAdapter(LocationAdapter());
    } catch (e) {
      print(e);
    }
  }

  static Future<Box?> openBox({required String name}) async {
    try {
      return await Hive.openBox(name);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<bool> putData(
      {required String boxName,
      required String key,
      required dynamic data}) async {
    try {
      var box = await openBox(name: boxName);
      if (box != null) {
        await box.put(key, data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> addLocation(
      {required double latitude,
      required double longitude,
      required String name,
      required String time}) async {
    try {
      final box = await Hive.openBox('locations');
      EasyLoading.showInfo('Location added offline');
      await box.add(Location(name, latitude, longitude, time));
      await box.close();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> deleteDatabase() async {
    try {
      await Hive.deleteFromDisk();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
