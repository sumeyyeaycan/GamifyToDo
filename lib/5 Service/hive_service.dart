// // ignore_for_file: file_names

// import 'package:hive_flutter/hive_flutter.dart';

// class SkillService {
//   static const String _boxName = 'test';

//   Future<Box<TestModel>> get _box async {
//     return await Hive.openBox<TestModel>(_boxName);
//   }

//   Future<void> addSkill(TestModel testModel) async {
//     testModelList.add(testModel);

//     final box = await _box;
//     await box.add(testModel);
//   }

//   Future<void> deleteSkill(TestModel testModel) async {
//     // Hive den sil
//     testModel.delete();

//     // Listeden sil
//     testModelList.remove(testModel);
//   }

//   Future<void> deleteAllSkills() async {
//     final box = await _box;
//     await box.clear();
//   }

//   Future<List<TestModel>> getAllTestModelsInHive() async {
//     final box = await _box;
//     return box.values.toList();
//   }

//   void saveDataInHive() async {
//     for (int i = 0; i < testModelList.length; i++) {
//       testModelList[i].save();
//     }
//   }
// }
