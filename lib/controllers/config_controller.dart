import 'package:get/get.dart';

import '../models/config_model.dart';

class ConfigController extends GetxController {
  final config = Rxn<ConfigModel>();

  final selectedAlarm = 0.obs;

  bool get hasConfig => config.value != null;

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
