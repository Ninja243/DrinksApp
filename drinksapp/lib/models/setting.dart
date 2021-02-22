class Setting {
  Map<String, bool> _settingValues;
  Map<String, String> _settingDescriptions;

  Setting() {
    _settingValues = {"under_18": false};
    _settingDescriptions = {"under_18": "Heli Mode"};
  }
}
