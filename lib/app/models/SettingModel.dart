
class SettingModel{
  bool? soundEnabled;
  bool? notificationsEnabled;
  String? appLocale;

  SettingModel({this.appLocale, this.notificationsEnabled, this.soundEnabled});

  factory SettingModel.fromJsom(Map<String, dynamic> json) => SettingModel(
    soundEnabled: json['sound'] == null ? false : json['sound'],
    notificationsEnabled: json['notifications'] == null ? false : json['notifications'],
    appLocale: json['locale'] == null ? 'en' : json['locale'],
  );

  Map<String, dynamic> toJson() => {
    "sound": this.soundEnabled,
    "notification": this.notificationsEnabled,
    "locale": this.appLocale,
  };

  void clear() => SettingModel();

}