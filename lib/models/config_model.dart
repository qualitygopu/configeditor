import 'alarm_model.dart';

class ConfigModel {
  List<AlarmModel> alarms;
  List<dynamic> silentHours;
  List<dynamic> songMaster;

  ConfigModel({
    required this.alarms,
    required this.silentHours,
    required this.songMaster,
  });

  factory ConfigModel.fromJson(Map<String, dynamic> json) {
    return ConfigModel(
      alarms: (json["AlarmConfig"] as List? ?? [])
          .map((e) => AlarmModel.fromJson(e))
          .toList(),

      silentHours: json["silentHours"] ?? [],

      songMaster: json["SongMaster"] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "AlarmConfig": alarms.map((e) => e.toJson()).toList(),

      "silentHours": silentHours,

      "SongMaster": songMaster,
    };
  }
}
