import 'dart:convert';

import 'package:get/get.dart';
import '../models/config_model.dart';
import '../services/json_service.dart';

class ConfigController extends GetxController {
  final config = Rxn<ConfigModel>();
  final _jsonService = JsonService();

  String currentFileName = "config.json";
  final selectedAlarm = 0.obs;

  bool get hasConfig => config.value != null;

  Future<void> openJson() async {
    final content = await _jsonService.pickJsonFile();

    if (content == null) return;

    final map = jsonDecode(content);

    config.value = ConfigModel.fromJson(map);
  }

  void saveJson() {
    if (config.value == null) return;

    _jsonService.downloadJson(config.value!.toJson(), currentFileName);
  }

  void setConfig(ConfigModel model) {
    config.value = model;
  }

  void selectAlarm(int index) {
    selectedAlarm.value = index;
  }

  void addAlarm() {
    if (config.value == null) return;

    config.value!.alarms.add(
      ConfigModel.fromJson({
        "AlarmConfig": [
          {
            "tit": "New Alarm",
            "id": "",
            "state": true,
            "tim": [
              [0, 0],
              [
                [6, 6],
              ],
              [
                [1, 31],
              ],
              [
                [1, 12],
              ],
              [1, 2, 3, 4, 5, 6, 7],
              [0],
            ],
            "SC": [0],
            "type": "time",
          },
        ],
      }).alarms.first,
    );

    config.refresh();
  }
}
