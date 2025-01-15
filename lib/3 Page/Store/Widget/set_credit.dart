import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/6%20Provider/add_store_item_providerr.dart';
import 'package:provider/provider.dart';

class SetCredit extends StatefulWidget {
  const SetCredit({
    super.key,
  });

  @override
  State<SetCredit> createState() => _SetCreditState();
}

class _SetCreditState extends State<SetCredit> {
  @override
  Widget build(BuildContext context) {
    late final AddStoreItemProvider provider = context.read<AddStoreItemProvider>();

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.panelBackground,
        borderRadius: AppColors.borderRadiusAll,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: AppColors.borderRadiusAll,
            onTap: () {
              if (provider.credit > 0) {
                setState(() {
                  provider.credit--;
                });
              }
            },
            onLongPress: () {
              setState(() {
                if (provider.credit >= 20) {
                  provider.credit -= 20;
                } else {
                  provider.credit = 0;
                }
              });
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
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Text(
                  provider.credit.toString(),
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 3),
                const Icon(Icons.monetization_on),
              ],
            ),
          ),
          InkWell(
            borderRadius: AppColors.borderRadiusAll,
            onTap: () {
              setState(() {
                provider.credit++;
              });
            },
            onLongPress: () {
              setState(() {
                provider.credit += 20;
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
      ),
    );
  }
}
