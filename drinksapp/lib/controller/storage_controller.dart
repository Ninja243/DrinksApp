import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class StorageController extends ChangeNotifier {
  var _box;
  bool isReady = false;

  StorageController() {
    init();
  }

  init() async {
    this._box = await Hive.openBox("ingredients");
    this.isReady = true;
  }

  store(String label, String json) {
    if (isReady) {
      this._box.put(label, json);
    }
  }

  String retrieve(String label) {
    if (isReady) {
      return _box.get(label);
    }
    return null;
  }
}
