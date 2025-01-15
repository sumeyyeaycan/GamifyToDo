import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:provider/provider.dart';

class TaskSlideActinos extends StatefulWidget {
  const TaskSlideActinos({
    super.key,
    required this.child,
    required this.taskModel,
  });

  final Widget child;
  final TaskModel taskModel;

  @override
  State<TaskSlideActinos> createState() => _TaskSlideActinosState();
}

class _TaskSlideActinosState extends State<TaskSlideActinos> {
  late final taskProvider = context.read<TaskProvider>();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(widget.taskModel.id),
      endActionPane: widget.taskModel.routineID != null
          ? null
          : ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.3,
              closeThreshold: 0.1,
              openThreshold: 0.1,
              dismissible: DismissiblePane(
                dismissThreshold: 0.3,
                closeOnCancel: true,
                confirmDismiss: () async {
                  taskProvider.changeTaskDate(
                    context: context,
                    taskModel: widget.taskModel,
                  );

                  return false;
                },
                onDismissed: () {},
              ),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    taskProvider.changeTaskDate(
                      context: context,
                      taskModel: widget.taskModel,
                    );
                  },
                  backgroundColor: AppColors.orange,
                  icon: Icons.calendar_month,
                  label: LocaleKeys.ChangeDate.tr(),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                ),
              ],
            ),
      startActionPane: widget.taskModel.routineID != null && !Helper().isSameDay(widget.taskModel.taskDate, DateTime.now())
          ? null
          : ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.5,
              closeThreshold: 0.1,
              openThreshold: 0.1,
              dismissible: DismissiblePane(
                dismissThreshold: 0.01,
                onDismissed: () {
                  taskProvider.failedTask(widget.taskModel);
                },
              ),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    taskProvider.failedTask(widget.taskModel);
                  },
                  backgroundColor: AppColors.red,
                  icon: Icons.close,
                  label: LocaleKeys.Failed.tr(),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                ),
                SlidableAction(
                  onPressed: (context) {
                    taskProvider.cancelTask(widget.taskModel);
                  },
                  backgroundColor: AppColors.purple,
                  icon: Icons.block,
                  label: LocaleKeys.Cancel.tr(),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                ),
              ],
            ),
      child: widget.child,
    );
  }
}
