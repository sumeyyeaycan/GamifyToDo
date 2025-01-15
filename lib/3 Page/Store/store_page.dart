import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/3%20Page/Store/Widget/store_item.dart';
import 'package:gamify_todo/5%20Service/locale_keys.g.dart';
import 'package:gamify_todo/6%20Provider/navbar_provider.dart';
import 'package:gamify_todo/6%20Provider/store_provider.dart';
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        context.read<NavbarProvider>().currentIndex = 1;
        context.read<NavbarProvider>().pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.Store.tr()),
          leading: const SizedBox(),
          actions: [
            Text(loginUser!.userCredit.toString(), style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 2),
            const Icon(Icons.monetization_on),
            const SizedBox(width: 10),
          ],
        ),
        body: ListView.builder(
          itemCount: context.watch<StoreProvider>().storeItemList.length,
          itemBuilder: (context, index) {
            return StoreItem(
              storeItemModel: context.read<StoreProvider>().storeItemList[index],
            );
          },
        ),
      ),
    );
  }
}
