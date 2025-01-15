import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Home/Widget/day_item.dart';
import 'package:gamify_todo/3%20Page/Home/Widget/task_list.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDate = context.watch<TaskProvider>().selectedDate;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: Row(
          children: [
            DayItem(date: selectedDate.subtract(const Duration(days: 1))),
            DayItem(date: selectedDate),
            DayItem(date: selectedDate.add(const Duration(days: 1))),
            InkWell(
              borderRadius: AppColors.borderRadiusAll,
              onTap: () {
                TaskProvider().changeSelectedDate(DateTime.now());
              },
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(Icons.today),
              ),
            ),
          ],
        ),
        actions: [
          // test button
          if (kDebugMode)
            InkWell(
              onTap: () {
                ServerManager().routineToTask();
              },
              child: const Text("Test 00:00"),
            ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  onTap: () {
                    TaskProvider().changeShowCompleted();
                  },
                  child: Text("${TaskProvider().showCompleted ? "Hide" : "Show"} Completed"),
                ),
              ];
            },
          ),
        ],
      ),
      body: const TaskList(),
    );
  }
}
