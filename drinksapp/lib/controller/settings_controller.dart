import 'package:drinksapp/common/enums.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:drinksapp/models/setting_entry.dart';

class SettingsController extends GetxController {
  Rx<GeneratorBehaviourType> _gtype = GeneratorBehaviourType.DEFAULT.obs;
  bool _isReady = false;
  SharedPreferences _prefs;
  RxList<SettingEntry> _settings = <SettingEntry>[].obs;

  bool ready() => this._isReady;

  int length() => this._settings.length;

  List<SettingEntry> getSettings() => this._settings;

  SettingEntry getSetting(int index) => this._settings[index];

  setActiveBehaviourType(GeneratorBehaviourType behaviourType) {
    //this._gtype.update((val) {
    //  val = behaviourType;
    //});
    //print("canUpdate: " + _gtype.canUpdate.toString());
    this._gtype.value = behaviourType;
  }

  GeneratorBehaviourType getActiveBehaviourType() => this._gtype.value;

  getActiveOBSBehaviourType() => this._gtype.obs;

  Future<bool> initWithFuture() =>
      Future.delayed(Duration(seconds: 0), () async {
        if (this._isReady == false) {
          _prefs = await SharedPreferences.getInstance();
          this._gtype.update((val) {
            val = GeneratorBehaviourType.DEFAULT;
          });
          if (_prefs.getStringList("settings") != null) {
            for (String s in _prefs.getStringList("settings")) {
              _settings.add(new SettingEntry.fromJson(jsonDecode(s)));
            }
          } else {
            this._settings.addAll([
              SettingEntry("Andi's Mode", "default"),
              SettingEntry("Freddy's Mode", "non_alcoholic"),
              SettingEntry("Heli's Mode", "under_18"),
              SettingEntry("Marie's Mode", "hugo_advert"),
              SettingEntry("Mweya's Mode", "death"),
              SettingEntry("Vinz's Mode", "water_only"),
            ]);
          }
          this._isReady = true;
        }
        return true;
      });

  saveSettings() {
    this._prefs.setString("settings", jsonEncode(this._settings));
  }

  GeneratorBehaviourType convertStringToGeneratorBehaviourType(String s) {
    return GeneratorBehaviourType.values.firstWhere((element) {
      return element
              .toString()
              .toLowerCase()
              .substring(element.toString().indexOf(".") + 1) ==
          s.toLowerCase();
    });
    //return null;
  }

  String getGeneratorBehaviourTypeDescription(GeneratorBehaviourType gtype) {
    for (SettingEntry entry in _settings) {
      if (gtype.toString() == entry.getID()) {
        return entry.getDescription();
      }
    }
    return null;
  }

  saveList() {
    List<String> l = [];
    for (SettingEntry s in this._settings) {
      l.add(jsonEncode(s));
    }
    _prefs.setStringList("settings", l);
  }
}
