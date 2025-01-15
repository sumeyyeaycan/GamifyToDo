import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/Enums/status_enum.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/6%20Provider/trait_provider.dart';
import 'package:gamify_todo/7%20Enum/task_status_enum.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/7%20Enum/trait_type_enum.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';
import 'package:get/route_manager.dart';

class TraitDetailPage extends StatefulWidget {
  const TraitDetailPage({
    super.key,
    required this.traitModel,
  });

  final TraitModel traitModel;

  @override
  State<TraitDetailPage> createState() => _TraitDetailPageState();
}

class _TraitDetailPageState extends State<TraitDetailPage> {
  TextEditingController traitTitleController = TextEditingController();
  String traitIcon = "🎯";
  Color selectedColor = AppColors.main;

  late Duration totalDuration;

  List<TaskModel> relatedTasks = [];
  List<TaskModel> relatedRoutines = [];

  @override
  void initState() {
    traitTitleController.text = widget.traitModel.title;
    traitIcon = widget.traitModel.icon;
    selectedColor = widget.traitModel.color;

    // TODO: burada her seferinde tüm listeyi kontrol etmek yerine bir üst sayfada tek seferde listeyi kontrol ederken süreleri dağıtmak olabilir mi?
    // bu trait ile bağlantılı taskların sürelerini topla
    totalDuration = TaskProvider().taskList.fold(
      Duration.zero,
      (previousValue, element) {
        if (((element.skillIDList != null && element.skillIDList!.contains(widget.traitModel.id)) || (element.attributeIDList != null && element.attributeIDList!.contains(widget.traitModel.id))) && element.remainingDuration != null) {
          if (element.type == TaskTypeEnum.CHECKBOX && element.status != TaskStatusEnum.COMPLETED) {
            return previousValue;
          }
          return previousValue +
              (element.type == TaskTypeEnum.CHECKBOX
                  ? element.remainingDuration!
                  : element.type == TaskTypeEnum.COUNTER
                      ? element.remainingDuration! * element.currentCount!
                      : element.currentDuration!);
        }
        return previousValue;
      },
    );

    // related tasks
    TaskProvider().taskList.where((element) {
      if (element.skillIDList != null && element.skillIDList!.contains(widget.traitModel.id)) {
        if (element.routineID != null) {
          relatedRoutines.add(element);
        } else {
          relatedTasks.add(element);
        }
      } else if (element.attributeIDList != null && element.attributeIDList!.contains(widget.traitModel.id)) {
        if (element.routineID != null) {
          relatedRoutines.add(element);
        } else {
          relatedTasks.add(element);
        }
      }
      return false;
    }).toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.traitModel.title} Detail',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          borderRadius: AppColors.borderRadiusAll,
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          InkWell(
            borderRadius: AppColors.borderRadiusAll,
            onTap: () async {
              if (traitTitleController.text.trim().isEmpty) {
                traitTitleController.clear();
                Helper().getMessage(
                  message: LocaleKeys.NameEmpty.tr(),
                  status: StatusEnum.WARNING,
                );
                return;
              }

              final TraitModel updatedTrait = TraitModel(
                id: widget.traitModel.id,
                title: traitTitleController.text,
                icon: traitIcon,
                color: selectedColor,
                type: widget.traitModel.type == TraitTypeEnum.SKILL ? TraitTypeEnum.SKILL : TraitTypeEnum.ATTRIBUTE,
              );

              TraitProvider().editTrait(updatedTrait);
              Get.back();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.check),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trait Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.panelBackground2,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: traitTitleController,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              hintText: "Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: AppColors.panelBackground2.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () async {
                            traitIcon = await Helper().showEmojiPicker(context);
                            setState(() {});
                          },
                          child: Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              color: selectedColor.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                traitIcon,
                                style: const TextStyle(fontSize: 28),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () async {
                            selectedColor = await Helper().selectColor();
                            setState(() {});
                          },
                          child: Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              color: selectedColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Total Duration Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: selectedColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      totalDuration.toLevel(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: selectedColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      totalDuration.textShort2hour(),
                      style: TextStyle(
                        fontSize: 16,
                        color: selectedColor.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Related Tasks Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Related Tasks",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: relatedTasks.length,
                          itemBuilder: (context, index) {
                            final TaskModel task = relatedTasks[index];
                            Duration allTimeDuration = Duration.zero;
                            int allTimeCount = 0;

                            for (var t in TaskProvider().taskList) {
                              if (t.routineID == task.routineID) {
                                if (t.type == TaskTypeEnum.TIMER) {
                                  allTimeDuration += t.currentDuration!;
                                } else if (t.type == TaskTypeEnum.COUNTER) {
                                  allTimeCount += t.currentCount!;
                                }
                              }
                            }

                            if (task.type == TaskTypeEnum.COUNTER) {
                              allTimeDuration += task.remainingDuration! * allTimeCount;
                            }

                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.panelBackground2,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      task.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    allTimeDuration.textShort2hour(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: selectedColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Related Routines",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: relatedRoutines.length,
                          itemBuilder: (context, index) {
                            final TaskModel task = relatedRoutines[index];
                            Duration allTimeDuration = Duration.zero;
                            int allTimeCount = 0;

                            for (var t in TaskProvider().taskList) {
                              if (t.routineID == task.routineID) {
                                if (t.type == TaskTypeEnum.TIMER) {
                                  allTimeDuration += t.currentDuration!;
                                } else if (t.type == TaskTypeEnum.COUNTER) {
                                  allTimeCount += t.currentCount!;
                                }
                              }
                            }

                            if (task.type == TaskTypeEnum.COUNTER) {
                              allTimeDuration += task.remainingDuration! * allTimeCount;
                            }

                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.panelBackground2,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      task.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    allTimeDuration.textShort2hour(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Delete Button
              Center(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    TraitProvider().removeTrait(widget.traitModel.id);
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.red.withValues(alpha: 0.9),
                    ),
                    child: Text(
                      LocaleKeys.Delete.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
