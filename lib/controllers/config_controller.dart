import 'dart:convert';

import 'package:get/get.dart';
import '../models/config_model.dart';
import '../services/json_service.dart';
import '../models/alarm_model.dart';

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
      AlarmModel(
        tit: "New Alarm",
        id: "",
        state: true,
        type: "time",
        sc: [0],
        tim: [
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
      ),
    );

    selectedAlarm.value = config.value!.alarms.length - 1;

    config.refresh();
  }

  void deleteAlarm() {
    if (config.value == null) return;

    if (config.value!.alarms.isEmpty) {
      return;
    }

    config.value!.alarms.removeAt(selectedAlarm.value);

    if (selectedAlarm.value > 0) {
      selectedAlarm.value--;
    }

    config.refresh();
  }

  void duplicateAlarm() {
    if (config.value == null) return;

    final src = config.value!.alarms[selectedAlarm.value];

    config.value!.alarms.add(
      AlarmModel(
        tit: "${src.tit} Copy",
        id: src.id,
        state: src.state,
        tim: List.from(src.tim),
        sc: List.from(src.sc),
        type: src.type,
      ),
    );

    config.refresh();
  }

  void addSong() {
    if (config.value == null) return;

    config.value!.songMaster.add([100, "LP", "", "CUS", "New Song"]);

    config.refresh();
  }

  void deleteLastSong() {
    if (config.value == null) return;

    if (config.value!.songMaster.isEmpty) {
      return;
    }

    config.value!.songMaster.removeLast();

    config.refresh();
  }
}
