import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/extensions.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/3%20Page/Store/add_store_item_page.dart';
import 'package:gamify_todo/5%20Service/global_timer.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/5%20Service/navigator_service.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';
import 'package:gamify_todo/6%20Provider/store_provider.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/store_item_model.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class StoreItem extends StatefulWidget {
  const StoreItem({
    super.key,
    required this.storeItemModel,
  });

  final ItemModel storeItemModel;

  @override
  State<StoreItem> createState() => _StoreItemState();
}

class _StoreItemState extends State<StoreItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        InkWell(
          onTap: () {
            storeItemAction();
          },
          onLongPress: () async {
            await NavigatorService()
                .goTo(
                  AddStoreItemPage(editItemModel: widget.storeItemModel),
                  transition: Transition.size,
                )
                .then(
                  (value) => StoreProvider().setStateItems(),
                );
          },
          borderRadius: AppColors.borderRadiusAll,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: AppColors.borderRadiusAll,
            ),
            child: Row(
              children: [
                storeItemIcon(),
                const SizedBox(width: 15),
                titleAndProgressWidgets(),
                const Spacer(),
                Row(
                  children: [
                    creditAmount(),
                    const SizedBox(width: 10),
                    buyButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget creditAmount() {
    if (widget.storeItemModel.credit == 0) return const SizedBox();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.panelBackground2.withAlpha(77),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "${widget.storeItemModel.credit}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.monetization_on,
            size: 20,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }

  InkWell buyButton() {
    return InkWell(
      borderRadius: AppColors.borderRadiusAll,
      onTap: () async {
        loginUser!.userCredit -= widget.storeItemModel.credit;

        if (widget.storeItemModel.type == TaskTypeEnum.TIMER) {
          widget.storeItemModel.currentDuration = widget.storeItemModel.currentDuration! + widget.storeItemModel.addDuration!;
        } else {
          widget.storeItemModel.currentCount = widget.storeItemModel.currentCount! + 1;
        }

        await ServerManager().updateUser(userModel: loginUser!);
        await ServerManager().updateItem(itemModel: widget.storeItemModel);
        StoreProvider().setStateItems();
      },
      child: Container(
        height: 45,
        constraints: const BoxConstraints(minWidth: 115),
        decoration: BoxDecoration(
          borderRadius: AppColors.borderRadiusAll,
          gradient: LinearGradient(
            colors: [AppColors.main.withAlpha(150), AppColors.main],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Center(
          child: Text(
            "${widget.storeItemModel.credit == 0 ? LocaleKeys.Add.tr() : LocaleKeys.Buy.tr()} ${widget.storeItemModel.type == TaskTypeEnum.COUNTER ? LocaleKeys.OnePiece.tr() : widget.storeItemModel.addDuration?.textLongDynamicWithoutZero()} ",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget storeItemIcon() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.panelBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        widget.storeItemModel.type == TaskTypeEnum.COUNTER
            ? Icons.remove
            : widget.storeItemModel.isTimerActive!
                ? Icons.pause
                : Icons.play_arrow,
        size: 30,
      ),
    );
  }

  void storeItemAction() async {
    if (widget.storeItemModel.type == TaskTypeEnum.COUNTER) {
      widget.storeItemModel.currentCount = widget.storeItemModel.currentCount! - 1;
      ServerManager().updateItem(itemModel: widget.storeItemModel);
      // TODO: - olursa disiplin düşecek
    } else {
      GlobalTimer().startStopTimer(
        storeItemModel: widget.storeItemModel,
      );

      ServerManager().updateItem(itemModel: widget.storeItemModel);
    }

    StoreProvider().setStateItems();
  }

  Widget titleAndProgressWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.storeItemModel.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        widget.storeItemModel.type == TaskTypeEnum.CHECKBOX
            ? const SizedBox()
            : widget.storeItemModel.type == TaskTypeEnum.COUNTER
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.panelBackground2.withAlpha(77),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${widget.storeItemModel.currentCount}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.panelBackground2.withAlpha(77),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.storeItemModel.currentDuration!.textShortDynamic(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: widget.storeItemModel.isTimerActive! ? AppColors.main : null,
                      ),
                    ),
                  ),
      ],
    );
  }
}
