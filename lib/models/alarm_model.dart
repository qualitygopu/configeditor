class AlarmModel {
  String tit;
  String? id;
  bool state;
  List<dynamic> tim;
  List<int> sc;
  String type;

  AlarmModel({
    required this.tit,
    required this.id,
    required this.state,
    required this.tim,
    required this.sc,
    required this.type,
  });

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      tit: json['tit'] ?? '',
      id: json['id'],
      state: json['state'] ?? false,
      tim: json['tim'] ?? [],
      sc: List<int>.from(json['SC'] ?? []),
      type: json['type'] ?? 'time',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tit": tit,
      "id": id,
      "state": state,
      "tim": tim,
      "SC": sc,
      "type": type,
    };
  }
}
