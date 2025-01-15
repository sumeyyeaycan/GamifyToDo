import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:provider/provider.dart';

class NotificationSwitch extends StatefulWidget {
  const NotificationSwitch({super.key});

  @override
  State<NotificationSwitch> createState() => _NotificationSwitchState();
}

class _NotificationSwitchState extends State<NotificationSwitch> {
  late final addTaskProvider = context.watch<AddTaskProvider>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.panelBackground,
        borderRadius: AppColors.borderRadiusAll,
      ),
      child: InkWell(
        borderRadius: AppColors.borderRadiusAll,
        onTap: () async {
          await changeNotificationStatus();
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 5),
              const Icon(
                Icons.notifications,
                size: 30,
              ),
              Switch(
                value: addTaskProvider.isNotificationOn,
                onChanged: (isNotificationOn) async {
                  await changeNotificationStatus();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future changeNotificationStatus() async {
    if (addTaskProvider.selectedTime == null) {
      final TimeOfDay? selectedTime = await Helper().selectTime(context);
      addTaskProvider.updateTime(selectedTime);

      if (selectedTime != null) {
        addTaskProvider.isNotificationOn = !addTaskProvider.isNotificationOn;
      }

      setState(() {});
    } else {
      addTaskProvider.isNotificationOn = !addTaskProvider.isNotificationOn;
      setState(() {});
    }
  }
}
