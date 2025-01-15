import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/3%20Page/Task%20Detail%20Page/widget/progress_bar.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/6%20Provider/trait_provider.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';

class TaskLog {
  final String dateTime;
  final String duration;

  TaskLog(this.dateTime, this.duration);
}

class TaskDetailViewModel {
  final TaskModel taskModel;
  Duration allTimeDuration = Duration.zero;
  int allTimeCount = 0;
  late DateTime taskRutinCreatedDate;
  List<Widget> attributeBars = [];
  List<Widget> skillBars = [];
  int completedTaskCount = 0;
  int failedTaskCount = 0;
  String bestHour = "15:00";
  String bestDay = "Wednesday";
  int longestStreak = 0;
  List<TaskLog> recentLogs = [];

  TaskDetailViewModel(this.taskModel);

  void initialize() {
    calculateStatistics();
    loadTraits();
    loadRecentLogs();
  }

  void calculateStatistics() {
    for (var task in TaskProvider().taskList) {
      if (task.routineID == taskModel.routineID) {
        if (taskModel.type == TaskTypeEnum.TIMER) {
          allTimeDuration += task.currentDuration!;
        } else if (taskModel.type == TaskTypeEnum.COUNTER) {
          allTimeCount += task.currentCount!;
        }

        if (task.status == TaskStatusEnum.COMPLETED) {
          completedTaskCount++;
        } else if (task.status == TaskStatusEnum.FAILED) {
          failedTaskCount++;
        }
      }
    }
    taskRutinCreatedDate = TaskProvider().routineList.firstWhere((element) => element.id == taskModel.routineID).createdDate;
  }

  void loadTraits() {
    if (taskModel.attributeIDList?.isNotEmpty ?? false) {
      attributeBars.addAll(
        taskModel.attributeIDList!.map((e) {
          final trait = TraitProvider().traitList.firstWhere((element) => element.id == e);
          return ProgressBar(
            title: trait.title,
            progress: 0.2,
            color: trait.color,
            icon: trait.icon,
          );
        }),
      );
    }

    if (taskModel.skillIDList?.isNotEmpty ?? false) {
      skillBars.addAll(
        taskModel.skillIDList!.map((e) {
          final trait = TraitProvider().traitList.firstWhere((element) => element.id == e);
          return ProgressBar(
            title: trait.title,
            progress: 0.7,
            color: trait.color,
            icon: trait.icon,
          );
        }),
      );
    }
  }

  void loadRecentLogs() {
    // TODO: Implement actual log loading
    recentLogs = List.generate(
      5,
      (index) => TaskLog("14 november 2024 15:14", "1h 5m"),
    );
  }

  bool get hasTraits => attributeBars.isNotEmpty || skillBars.isNotEmpty;

  int get daysInProgress => DateTime.now().difference(taskRutinCreatedDate).inDays;

  String get averagePerDay => (allTimeDuration / (daysInProgress == 0 ? 1 : daysInProgress).abs()).textShortDynamic();

  int get successRate => (completedTaskCount + failedTaskCount) == 0 ? 0 : ((completedTaskCount / (completedTaskCount + failedTaskCount)) * 100).toInt();
}
