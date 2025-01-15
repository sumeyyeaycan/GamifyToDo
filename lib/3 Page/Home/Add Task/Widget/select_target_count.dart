import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/6%20Provider/add_store_item_providerr.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:provider/provider.dart';

class SelectTargetCount extends StatefulWidget {
  const SelectTargetCount({
    super.key,
    this.isStore = false,
  });

  final bool isStore;

  @override
  State<SelectTargetCount> createState() => _SelectTargetCountState();
}

class _SelectTargetCountState extends State<SelectTargetCount> {
  late final dynamic provider = widget.isStore ? context.read<AddStoreItemProvider>() : context.read<AddTaskProvider>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: AppColors.borderRadiusAll,
          onTap: () {
            if (provider.targetCount > 1) {
              setState(() {
                provider.targetCount--;
              });
            }
          },
          onLongPress: () {
            if (provider.targetCount > 20) {
              setState(() {
                provider.targetCount -= 20;
              });
            } else if (provider.targetCount > 1) {
              setState(() {
                provider.targetCount = 1;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppColors.borderRadiusAll,
            ),
            padding: const EdgeInsets.all(5),
            child: const Icon(
              Icons.remove,
              size: 30,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: AppColors.borderRadiusAll,
          ),
          padding: const EdgeInsets.all(5),
          child: Text(
            provider.targetCount.toString(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        InkWell(
          borderRadius: AppColors.borderRadiusAll,
          onTap: () {
            setState(() {
              provider.targetCount++;
            });
          },
          onLongPress: () {
            setState(() {
              provider.targetCount += 20;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppColors.borderRadiusAll,
            ),
            padding: const EdgeInsets.all(5),
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
