import 'package:flutter/material.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';

class RoutineModel {
  int id; // id si
  String title; // başlığı
  TaskTypeEnum type; // türü
  final DateTime createdDate; // oluşturulma tarihi
  DateTime startDate; // başlama tarihi
  TimeOfDay? time; // saati
  bool isNotificationOn; // notification açık mı
  Duration? remainingDuration; // timer ise hedef süre timer değilse tecrübe puanı buna göre gelecek
  int? targetCount; // counter ise hedef sayı
  List<int> repeatDays; // tekrar günleri
  List<int>? attirbuteIDList; // etki edeceği özellikler
  List<int>? skillIDList; // etki edecği yetenekler
  bool isCompleted; // tamamlandı mı
  int priority; // öncelik değeri (1: Yüksek, 2: Orta, 3: Düşük)

  RoutineModel({
    this.id = 0,
    required this.title,
    required this.type,
    required this.createdDate,
    required this.startDate,
    this.time,
    required this.isNotificationOn,
    this.remainingDuration,
    this.targetCount,
    required this.repeatDays,
    this.attirbuteIDList,
    this.skillIDList,
    required this.isCompleted,
    this.priority = 3,
  });

  factory RoutineModel.fromJson(Map<String, dynamic> json) {
    Duration stringToDuration(String timeString) {
      List<String> split = timeString.split(':');
      return Duration(hours: int.parse(split[0]), minutes: int.parse(split[1]), seconds: int.parse(split[2]));
    }

    TaskTypeEnum type = TaskTypeEnum.values.firstWhere((e) => e.toString().split('.').last == json['type']);

    return RoutineModel(
      id: json['id'],
      title: json['title'],
      type: type,
      createdDate: DateTime.parse(json['created_date']),
      startDate: DateTime.parse(json['start_date']),
      time: json['time'] != null ? TimeOfDay.fromDateTime(DateTime.parse("1970-01-01 ${json['time']}")) : null,
      isNotificationOn: json['is_notification_on'],
      remainingDuration: json['remaining_duration'] != null ? stringToDuration(json['remaining_duration']) : null,
      targetCount: json['target_count'],
      repeatDays: (json['repeat_days'] as List).map((e) => int.parse(e.toString())).toList(),
      attirbuteIDList: json['attribute_id_list'] != null ? List<int>.from(json['attribute_id_list']) : null,
      skillIDList: json['skill_id_list'] != null ? List<int>.from(json['skill_id_list']) : null,
      isCompleted: json['is_completed'],
      priority: json['priority'] ?? 3,
    );
  }

  Map<String, dynamic> toJson() {
    String durationToString(Duration duration) {
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);
      final seconds = duration.inSeconds.remainder(60);

      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }

    return {
      'id': id,
      'title': title,
      'type': type.toString().split('.').last,
      'created_date': createdDate.toIso8601String(),
      'start_date': startDate.toIso8601String(),
      'time': time != null ? '${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}:00' : null,
      'is_notification_on': isNotificationOn,
      'remaining_duration': remainingDuration != null ? durationToString(remainingDuration!) : null,
      'target_count': targetCount,
      'repeat_days': repeatDays,
      'attribute_id_list': attirbuteIDList,
      'skill_id_list': skillIDList,
      'is_completed': isCompleted,
      'priority': priority,
    };
  }
}
