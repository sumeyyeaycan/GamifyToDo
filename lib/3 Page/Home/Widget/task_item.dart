import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gamify_todo/1%20Core/Enums/status_enum.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Add%20Task/add_task_page.dart';
import 'package:gamify_todo/3%20Page/Home/Widget/task_slide_actions.dart';
import 'package:gamify_todo/3%20Page/Task%20Detail%20Page/routine_detail_page.dart';
import 'package:gamify_todo/5%20Service/app_helper.dart';
import 'package:gamify_todo/5%20Service/global_timer.dart';
import 'package:gamify_todo/5%20Service/home_widget_service.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/5%20Service/navigator_service.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isIncrementing = false;

  @override
  Widget build(BuildContext context) {
    return TaskSlideActinos(
      taskModel: widget.taskModel,
      child: Opacity(
        opacity: widget.taskModel.status != null && !(widget.taskModel.type == TaskTypeEnum.TIMER && widget.taskModel.isTimerActive!) ? 0.3 : 1.0,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            // progress(),
            InkWell(
              onTap: () {
                if (widget.taskModel.routineID != null && (!Helper().isBeforeOrSameDay(widget.taskModel.taskDate, DateTime.now()))) {
                  Helper().getMessage(
                    status: StatusEnum.WARNING,
                    message: LocaleKeys.RoutineForFuture.tr(),
                  );
                } else {
                  taskAction();
                }
              },
              onLongPress: () async {
                if (widget.taskModel.routineID != null) {
                  await NavigatorService()
                      .goTo(
                    RoutineDetailPage(
                      taskModel: widget.taskModel,
                    ),
                    transition: Transition.size,
                  )
                      .then(
                    (value) {
                      TaskProvider().updateItems();
                    },
                  );
                } else {
                  await NavigatorService()
                      .goTo(
                    AddTaskPage(
                      editTask: widget.taskModel,
                    ),
                    transition: Transition.size,
                  )
                      .then(
                    (value) {
                      TaskProvider().updateItems();
                    },
                  );
                }
              },
              borderRadius: AppColors.borderRadiusAll,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: widget.taskModel.type == TaskTypeEnum.TIMER && widget.taskModel.isTimerActive! ? null : AppColors.borderRadiusAll,
                    ),
                    child: Row(
                      children: [
                        taskActionIcon(),
                        const SizedBox(width: 5),
                        titleAndDescriptionWidgets(),
                        const SizedBox(width: 10),
                        notificationWidgets(),
                      ],
                    ),
                  ),
                  priortyLine(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget priortyLine() {
    if (widget.taskModel.priority == 3) return const SizedBox();

    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (widget.taskModel.priority == 1 ? AppColors.red : AppColors.orange2).withValues(alpha: 0.7),
            Colors.transparent,
          ],
          stops: const [0, 1],
        ),
      ),
    );
  }

  Widget progressText() {
    if (widget.taskModel.type == TaskTypeEnum.CHECKBOX && widget.taskModel.status == null) return const SizedBox();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.taskModel.type != TaskTypeEnum.CHECKBOX) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.panelBackground2.withAlpha(77),
              borderRadius: BorderRadius.circular(8),
            ),
            child: widget.taskModel.type == TaskTypeEnum.COUNTER
                ? Text(
                    "${widget.taskModel.currentCount ?? 0}/${widget.taskModel.targetCount ?? 0}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    "${widget.taskModel.currentDuration!.textShortDynamic()}/${widget.taskModel.remainingDuration!.textShortDynamic()}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: widget.taskModel.isTimerActive! ? AppColors.main : null,
                    ),
                  ),
          ),
          const SizedBox(width: 5),
        ],
        statusText(),
      ],
    );
  }

  AnimatedContainer progress() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 2,
      width: widget.taskModel.status == TaskStatusEnum.COMPLETED
          ? 1.sw
          : widget.taskModel.type == TaskTypeEnum.TIMER
              ? ((widget.taskModel.currentDuration?.inSeconds ?? 0) / (widget.taskModel.remainingDuration?.inSeconds ?? 1)).clamp(0.0, 1.0) * 1.sw
              : widget.taskModel.type == TaskTypeEnum.COUNTER
                  ? ((widget.taskModel.currentCount ?? 0) / (widget.taskModel.targetCount ?? 1)).clamp(0.0, 1.0) * 1.sw
                  : 0.sw,
      decoration: BoxDecoration(
        color: AppColors.deepMain,
      ),
    );
  }

  Widget taskActionIcon() {
    final priorityColor = (widget.taskModel.priority == 1
            ? AppColors.red
            : widget.taskModel.priority == 2
                ? AppColors.orange2
                : AppColors.text)
        .withValues(alpha: 0.9);

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.panelBackground,
        borderRadius: AppColors.borderRadiusAll,
      ),
      child: widget.taskModel.type == TaskTypeEnum.COUNTER
          ? GestureDetector(
              onTap: () => taskAction(),
              onLongPressStart: (_) async {
                _isIncrementing = true;
                while (_isIncrementing && mounted) {
                  setState(() {
                    taskAction();
                  });
                  await Future.delayed(const Duration(milliseconds: 60));
                }
              },
              onLongPressEnd: (_) {
                _isIncrementing = false;
              },
              child: Icon(
                Icons.add,
                size: 27,
                color: priorityColor,
              ),
            )
          : Icon(
              widget.taskModel.type == TaskTypeEnum.CHECKBOX
                  ? widget.taskModel.status == TaskStatusEnum.COMPLETED
                      ? Icons.check_box
                      : Icons.check_box_outline_blank
                  : widget.taskModel.isTimerActive!
                      ? Icons.pause
                      : Icons.play_arrow,
              size: 27,
              color: priorityColor,
            ),
    );
  }

  void taskAction() {
    if (widget.taskModel.type == TaskTypeEnum.CHECKBOX) {
      widget.taskModel.status = (widget.taskModel.status == null || widget.taskModel.status != TaskStatusEnum.COMPLETED) ? TaskStatusEnum.COMPLETED : null;

      AppHelper().addCreditByProgress(widget.taskModel.remainingDuration);
      HomeWidgetService.updateTaskCount();
    } else if (widget.taskModel.type == TaskTypeEnum.COUNTER) {
      widget.taskModel.currentCount = widget.taskModel.currentCount! + 1;

      AppHelper().addCreditByProgress(widget.taskModel.remainingDuration);

      if (widget.taskModel.currentCount! >= widget.taskModel.targetCount!) {
        widget.taskModel.status = TaskStatusEnum.COMPLETED;
        HomeWidgetService.updateTaskCount();
      }
    } else {
      GlobalTimer().startStopTimer(
        taskModel: widget.taskModel,
      );
    }

    ServerManager().updateTask(taskModel: widget.taskModel);

    if (!_isIncrementing) {
      TaskProvider().updateItems();
    }
  }

  Widget titleAndDescriptionWidgets() {
    final priorityColor = (widget.taskModel.priority == 1
            ? AppColors.red
            : widget.taskModel.priority == 2
                ? AppColors.orange2
                : AppColors.text)
        .withValues(alpha: 0.9);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AutoSizeText(
            widget.taskModel.title,
            maxLines: 1,
            minFontSize: 14,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: priorityColor,
            ),
          ),
          if (widget.taskModel.description != null && widget.taskModel.description!.isNotEmpty)
            Text(
              widget.taskModel.description!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: priorityColor.withValues(alpha: 0.7),
              ),
            ),
          progressText(),
        ],
      ),
    );
  }

  Widget statusText() {
    switch (widget.taskModel.status) {
      case TaskStatusEnum.FAILED:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.red.withAlpha(100),
            borderRadius: AppColors.borderRadiusAll,
          ),
          child: Text(
            LocaleKeys.Failed.tr(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case TaskStatusEnum.CANCEL:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.purple.withAlpha(100),
            borderRadius: AppColors.borderRadiusAll,
          ),
          child: Text(
            LocaleKeys.Cancel.tr(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case TaskStatusEnum.COMPLETED:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.green.withAlpha(80),
            borderRadius: AppColors.borderRadiusAll,
          ),
          child: Text(
            LocaleKeys.Completed.tr(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  Widget notificationWidgets() {
    return Row(
      children: [
        if (widget.taskModel.time != null) ...[
          Text(
            widget.taskModel.time!.to24hours(),
          ),
          const SizedBox(width: 5),
        ],
        if (widget.taskModel.isNotificationOn) ...[
          Icon(
            Icons.alarm,
            color: AppColors.deepMain,
          ),
        ],
      ],
    );
  }
}
