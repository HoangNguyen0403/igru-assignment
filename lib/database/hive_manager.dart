// Package imports:
import 'package:hive_flutter/hive_flutter.dart';

enum HiveBoxKey { products }

class HiveManager {
  static Future<HiveManager> getInstance() async {
    await Future.forEach<HiveBoxKey>(
      HiveBoxKey.values,
      (box) async => await Hive.openBox(box.name),
    );

    return HiveManager();
  }

  void clearBoxes(List<HiveBoxKey> boxes) {
    for (var boxKey in boxes) {
      final box = Hive.box(boxKey.name);
      box.clear();
    }
  }

  void deleteAllDataFromBox(String boxName) => _deleteAllDataFromBox(boxName);

  void deleteDataWithKey(String boxName, String key) =>
      _deleteDataByKeyFromBox(boxName, key);

  List<T> getListData<T>(String boxName) => _getListDataFromBox<T>(boxName);

  T getDataWithKey<T>(String boxName, String key) =>
      _getDataWithKeyFromBox(boxName, key);

  void putDataWithKey<T>(String boxName, String key, T valueStore) =>
      _putDataByKeyToBox<T>(boxName, key, valueStore);

  List<T> _getListDataFromBox<T>(String boxName) {
    final box = Hive.box(boxName);

    return box.isNotEmpty ? box.values.map<T>((value) => value).toList() : [];
  }

  T _getDataWithKeyFromBox<T>(String boxName, String key) {
    final box = Hive.box(boxName);

    return box.get(key);
  }

  void _putDataByKeyToBox<T>(String boxName, String key, T valueStore) {
    final box = Hive.box(boxName);
    box.put(key, valueStore);
  }

  void _deleteDataByKeyFromBox(String boxName, String key) {
    final box = Hive.box(boxName);
    box.delete(key);
  }

  void _deleteAllDataFromBox(String boxName) {
    final box = Hive.box(boxName);
    box.clear();
  }
}
