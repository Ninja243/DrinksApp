class SettingEntry {
  String _description;
  String _id;

  SettingEntry(String description, String id) {
    this._id = id;
    this._description = description;
  }

  String getID() {
    return this._id;
  }

  String getDescription() {
    return this._description;
  }

  setID(String id) {
    this._id = id;
  }

  setDescription(String description) {
    this._description = description;
  }

  SettingEntry.fromJson(Map<String, dynamic> json) {
    this._description = json["description"];
    this._id = json["id"];
  }

  Map<String, dynamic> toJson() => {
        'description': this._description,
        'id': this._id
      };
}
