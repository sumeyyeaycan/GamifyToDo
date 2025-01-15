import 'package:flutter/material.dart';
import 'package:gamify_todo/5%20Service/server_manager.dart';
import 'package:gamify_todo/7%20Enum/task_type_enum.dart';
import 'package:gamify_todo/8%20Model/store_item_model.dart';

class StoreProvider with ChangeNotifier {
  // burayı singelton yaptım gayet de iyi oldu neden normalde de context den kullanıyoruz anlamadım. galiba "watch" için olabilir. sibelton kısmını global timer için yaptım.
  static final StoreProvider _instance = StoreProvider._internal();

  factory StoreProvider() {
    return _instance;
  }

  StoreProvider._internal();
// ?? - kredi ve itemler - ye düşebilecek ama bu disipinden eksilmesine sebep oalcak
  List<ItemModel> storeItemList = [
    ItemModel(
      id: 0,
      title: "Game",
      type: TaskTypeEnum.TIMER,
      isTimerActive: false,
      addDuration: const Duration(hours: 1),
      currentDuration: const Duration(minutes: 0),
      credit: 6,
    ),
    ItemModel(
      id: 1,
      title: "Movie",
      type: TaskTypeEnum.COUNTER,
      currentCount: 0,
      credit: 3,
    ),
  ];

  void addItem(ItemModel itemModel) async {
    final int storeItemId = await ServerManager().addItem(itemModel: itemModel);

    itemModel.id = storeItemId;

    storeItemList.add(itemModel);

    notifyListeners();
  }

  void deleteItem(int id) async {
    await ServerManager().deleteItem(id: id);

    storeItemList.removeWhere((element) => element.id == id);

    notifyListeners();
  }

  void updateItem(ItemModel itemModel) async {
    await ServerManager().updateItem(itemModel: itemModel);

    final int index = storeItemList.indexWhere((element) => element.id == itemModel.id);

    storeItemList[index] = itemModel;

    notifyListeners();
  }

  void setStateItems() {
    notifyListeners();
  }
}
