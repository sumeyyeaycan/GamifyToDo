import 'package:flutter/material.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';

class AddTaskProvider with ChangeNotifier {
  // Widget variables
  TextEditingController taskNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TimeOfDay? selectedTime;
  DateTime selectedDate = DateTime.now();
  bool isNotificationOn = false;
  int targetCount = 1;
  Duration taskDuration = const Duration(hours: 0, minutes: 0);
  TaskTypeEnum selectedTaskType = TaskTypeEnum.CHECKBOX;
  List<int> selectedDays = [];
  List<TraitModel> selectedTraits = [];
  int priority = 3;

  void updateTime(TimeOfDay? time) {
    selectedTime = time;

    if (selectedTime == null) {
      isNotificationOn = false;
    }

    notifyListeners();
  }

  void updatePriority(int value) {
    priority = value;
    notifyListeners();
  }
}
