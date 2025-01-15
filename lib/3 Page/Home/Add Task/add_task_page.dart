import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/Enums/status_enum.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/duraiton_picker.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/notification_switch.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_date.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_days.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_priority.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_task_type.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_time.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/select_trait.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/task_description.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/Widget/task_name.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/5%20Service/navigator_service.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/6%20Provider/trait_provider.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';
import 'package:gamify_todo/8%20Model/rutin_model.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:gamify_todo/3%20Page/Task%20Detail%20Page/widget/edit_progress_widget.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({
    super.key,
    this.editTask,
  });

  final TaskModel? editTask;

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late final addTaskProvider = context.read<AddTaskProvider>();
  late final taskProvider = context.read<TaskProvider>();

  bool isLoadign = false;

  @override
  void initState() {
    super.initState();

    if (widget.editTask != null) {
      addTaskProvider.taskNameController.text = widget.editTask!.title;
      addTaskProvider.descriptionController.text = widget.editTask!.description ?? '';
      addTaskProvider.selectedTime = widget.editTask!.time;
      addTaskProvider.selectedDate = widget.editTask!.taskDate;
      addTaskProvider.isNotificationOn = widget.editTask!.isNotificationOn;
      addTaskProvider.targetCount = widget.editTask!.targetCount ?? 1;
      addTaskProvider.taskDuration = widget.editTask!.remainingDuration ?? const Duration(hours: 0, minutes: 0);
      addTaskProvider.selectedTaskType = widget.editTask!.type;
      addTaskProvider.selectedDays = widget.editTask!.routineID == null ? [] : taskProvider.routineList.firstWhere((element) => element.id == widget.editTask!.routineID).repeatDays;
      addTaskProvider.selectedTraits = TraitProvider().traitList.where((element) => (widget.editTask!.attributeIDList != null && widget.editTask!.attributeIDList!.contains(element.id)) || (widget.editTask!.skillIDList != null && widget.editTask!.skillIDList!.contains(element.id))).toList();
      addTaskProvider.priority = widget.editTask!.priority;
    } else {
      addTaskProvider.taskNameController.clear();
      addTaskProvider.descriptionController.clear();
      addTaskProvider.selectedTime = null;
      addTaskProvider.selectedDate = context.read<TaskProvider>().selectedDate;
      addTaskProvider.isNotificationOn = false;
      addTaskProvider.targetCount = 1;
      addTaskProvider.taskDuration = const Duration(hours: 0, minutes: 0);
      addTaskProvider.selectedTaskType = TaskTypeEnum.CHECKBOX;
      addTaskProvider.selectedDays.clear();
      addTaskProvider.selectedTraits.clear();
      addTaskProvider.priority = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editTask != null
            ? LocaleKeys.EditTask.tr()
            : widget.editTask?.routineID != null
                ? LocaleKeys.EditRoutine.tr()
                : LocaleKeys.AddTask.tr()),
        leading: InkWell(
          borderRadius: AppColors.borderRadiusAll,
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          TextButton(
            onPressed: addTask,
            child: Text(
              LocaleKeys.Save.tr(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              if (widget.editTask != null) ...[
                const SizedBox(height: 10),
                EditProgressWidget.forTask(task: widget.editTask!),
              ],
              const SizedBox(height: 10),
              TaskName(autoFocus: widget.editTask == null),
              const SizedBox(height: 5),
              const TaskDescription(),
              const SizedBox(height: 10),
              const SelectPriority(),
              const SizedBox(height: 10),
              if (widget.editTask?.routineID == null)
                const Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: SelectDate(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          SelectTime(),
                          SizedBox(height: 10),
                          NotificationSwitch(),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const DurationPickerWidget(),
                  if (widget.editTask == null) const SelectTaskType(),
                ],
              ),
              const SizedBox(height: 10),
              if (widget.editTask == null || (widget.editTask != null && widget.editTask!.routineID != null)) const SelectDays(),
              const SizedBox(height: 10),
              const SelectTraitList(isSkill: false),
              const SizedBox(height: 10),
              const SelectTraitList(isSkill: true),
              const SizedBox(height: 50),
              if (widget.editTask != null)
                InkWell(
                  borderRadius: AppColors.borderRadiusAll,
                  onTap: () {
                    if (widget.editTask?.routineID == null) {
                      taskProvider.deleteTask(widget.editTask!);
                    } else {
                      taskProvider.deleteRoutine(widget.editTask!.routineID!);
                    }

                    NavigatorService().goBackAll();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: AppColors.borderRadiusAll,
                      color: AppColors.red,
                    ),
                    child: Text(
                      LocaleKeys.Delete.tr(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void addTask() async {
    if (addTaskProvider.taskNameController.text.trim().isEmpty) {
      addTaskProvider.taskNameController.clear();

      Helper().getMessage(
        message: LocaleKeys.TraitNameEmpty.tr(),
        status: StatusEnum.WARNING,
      );
      return;
    }

    if (addTaskProvider.selectedDays.isNotEmpty && Helper().isBeforeDay(addTaskProvider.selectedDate, DateTime.now())) {
      Helper().getMessage(
        message: LocaleKeys.RoutineStartDateError.tr(),
        status: StatusEnum.WARNING,
      );
      return;
    }

    if (isLoadign) return;

    isLoadign = true;

    if (widget.editTask != null) {
      taskProvider.editTask(
        selectedDays: addTaskProvider.selectedDays,
        taskModel: TaskModel(
          id: widget.editTask!.id,
          routineID: widget.editTask!.routineID,
          title: addTaskProvider.taskNameController.text,
          description: addTaskProvider.descriptionController.text.trim().isEmpty ? null : addTaskProvider.descriptionController.text,
          type: addTaskProvider.selectedTaskType,
          taskDate: addTaskProvider.selectedDate,
          time: addTaskProvider.selectedTime,
          isNotificationOn: addTaskProvider.isNotificationOn,
          currentDuration: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? widget.editTask!.currentDuration ?? const Duration(seconds: 0) : null,
          remainingDuration: addTaskProvider.taskDuration,
          currentCount: addTaskProvider.selectedTaskType == TaskTypeEnum.COUNTER ? widget.editTask!.currentCount ?? 0 : null,
          targetCount: addTaskProvider.targetCount,
          isTimerActive: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? false : null,
          attributeIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.ATTRIBUTE).map((e) => e.id).toList(),
          skillIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.SKILL).map((e) => e.id).toList(),
          status: widget.editTask!.status,
          priority: addTaskProvider.priority,
        ),
      );
    } else {
      if (addTaskProvider.selectedDays.isEmpty) {
        taskProvider.addTask(
          TaskModel(
            title: addTaskProvider.taskNameController.text,
            description: addTaskProvider.descriptionController.text.trim().isEmpty ? null : addTaskProvider.descriptionController.text,
            type: addTaskProvider.selectedTaskType,
            taskDate: addTaskProvider.selectedDate,
            time: addTaskProvider.selectedTime,
            isNotificationOn: addTaskProvider.isNotificationOn,
            currentDuration: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? Duration.zero : null,
            remainingDuration: addTaskProvider.taskDuration,
            currentCount: addTaskProvider.selectedTaskType == TaskTypeEnum.COUNTER ? 0 : null,
            targetCount: addTaskProvider.targetCount,
            isTimerActive: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? false : null,
            attributeIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.ATTRIBUTE).map((e) => e.id).toList(),
            skillIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.SKILL).map((e) => e.id).toList(),
            priority: addTaskProvider.priority,
          ),
        );
      } else {
        await taskProvider.addRoutine(
          RoutineModel(
            title: addTaskProvider.taskNameController.text,
            type: addTaskProvider.selectedTaskType,
            createdDate: DateTime.now(),
            startDate: addTaskProvider.selectedDate,
            time: addTaskProvider.selectedTime,
            isNotificationOn: addTaskProvider.isNotificationOn,
            remainingDuration: addTaskProvider.taskDuration,
            targetCount: addTaskProvider.targetCount,
            repeatDays: addTaskProvider.selectedDays,
            attirbuteIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.ATTRIBUTE).map((e) => e.id).toList(),
            skillIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.SKILL).map((e) => e.id).toList(),
            isCompleted: false,
            priority: addTaskProvider.priority,
          ),
        );

        if (addTaskProvider.selectedDays.contains(DateTime.now().weekday - 1) && (Helper().isBeforeOrSameDay(addTaskProvider.selectedDate, DateTime.now()))) {
          taskProvider.addTask(
            TaskModel(
              title: addTaskProvider.taskNameController.text,
              description: addTaskProvider.descriptionController.text.trim().isEmpty ? null : addTaskProvider.descriptionController.text,
              routineID: taskProvider.routineList.last.id,
              type: addTaskProvider.selectedTaskType,
              taskDate: addTaskProvider.selectedDate,
              time: addTaskProvider.selectedTime,
              isNotificationOn: addTaskProvider.isNotificationOn,
              currentDuration: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? Duration.zero : null,
              remainingDuration: addTaskProvider.taskDuration,
              currentCount: addTaskProvider.selectedTaskType == TaskTypeEnum.COUNTER ? 0 : null,
              targetCount: addTaskProvider.targetCount,
              isTimerActive: addTaskProvider.selectedTaskType == TaskTypeEnum.TIMER ? false : null,
              attributeIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.ATTRIBUTE).map((e) => e.id).toList(),
              skillIDList: addTaskProvider.selectedTraits.where((element) => element.type == TraitTypeEnum.SKILL).map((e) => e.id).toList(),
              priority: addTaskProvider.priority,
            ),
          );
        } else {
          taskProvider.updateItems();
        }
      }
    }

    NavigatorService().goBackAll();
  }
}
