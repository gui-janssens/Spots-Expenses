import 'package:hive/hive.dart';

class Boxes {
  static const String auth = 'auth';
}

class Keys {
  static const String token = 'token';
}

class HiveService {
  static Future init() async {
    Hive.init(null);
  }

  // Get a box, initializing if necessary
  static Future<Box> getBox({required String boxName}) async {
    return await Hive.openBox(boxName);
  }

  // check if there is data in a specific box
  static Future<bool> boxNotEmpty({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    return openBox.length != 0;
  }

  // add data to specified box
  static Future addToBox<T>({
    required String boxName,
    required Map<String, dynamic> keyValuePairs,
  }) async {
    final openBox = await Hive.openBox(boxName);
    keyValuePairs.forEach(
      (key, value) async {
        await openBox.put(key, value);
      },
    );
  }

  // deletes key-value pair from box
  static Future removeFromBox<T>(
      {required String boxName, required String key}) async {
    final openBox = await Hive.openBox(boxName);
    await openBox.delete(key);
  }

  // wipes box
  static Future clearBox({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    await openBox.clear();
  }

  // get data from box with specified key
  static Future getDataFromBox<T>(
      {required String boxName, required String key}) async {
    final openBox = await Hive.openBox(boxName);
    return openBox.get(key);
  }

  // get all data stored in specified box
  static Future getAllDataFromBox<T>({required String boxName}) async {
    var boxMap = {};
    final openBox = await Hive.openBox(boxName);
    var length = openBox.length;
    for (var i = 0; i < length; i++) {
      boxMap[openBox.keyAt(i)] = openBox.getAt(i);
    }
    return boxMap;
  }
}
