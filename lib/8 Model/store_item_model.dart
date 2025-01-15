import 'package:gamify_todo/7%20Enum/task_type_enum.dart';

// !!!! şuan için sadece yapılacak. skillere etki etmeyecek

class ItemModel {
  int id; // id si
  final String title; // başlığı
  final TaskTypeEnum type; // türü
  Duration? currentDuration; // timer ise süre buradan takip edilecek
  final Duration? addDuration; // timer ise hedef süre timer değilse tecrübe puanı buna göre gelecek
  int? currentCount; // counter ise sayı buradan takip edilecek
  bool? isTimerActive; // timer aktif mi
  int credit; // timer aktif mi

  ItemModel({
    this.id = 0,
    required this.title,
    required this.type,
    this.currentDuration,
    this.addDuration,
    this.currentCount,
    this.isTimerActive,
    required this.credit,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    Duration stringToDuration(String timeString) {
      List<String> split = timeString.split(':');
      return Duration(hours: int.parse(split[0]), minutes: int.parse(split[1]), seconds: int.parse(split[2]));
    }

    final TaskTypeEnum type = TaskTypeEnum.values.firstWhere((e) => e.toString().split('.').last == json['type']);

    return ItemModel(
      id: json['id'],
      title: json['title'],
      type: type,
      currentDuration: json['current_duration'] != null ? stringToDuration(json['current_duration']) : null,
      addDuration: json['add_duration'] != null ? stringToDuration(json['add_duration']) : null,
      currentCount: json['current_count'],
      isTimerActive: json['is_timer_active'] ?? (type == TaskTypeEnum.TIMER ? false : null),
      credit: json['credit'],
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
      'current_duration': currentDuration != null ? durationToString(currentDuration!) : null,
      'add_duration': addDuration != null ? durationToString(addDuration!) : null,
      'current_count': currentCount,
      'credit': credit,
      'is_timer_active': isTimerActive,
    };
  }
}
