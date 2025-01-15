import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gamify_todo/1%20Core/Enums/status_enum.dart';
import 'package:gamify_todo/1%20Core/helper.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/8%20Model/rutin_model.dart';
import 'package:gamify_todo/8%20Model/store_item_model.dart';
import 'package:gamify_todo/8%20Model/task_model.dart';
import 'package:gamify_todo/8%20Model/trait_model.dart';
import 'package:gamify_todo/8%20Model/user_model.dart';

class ServerManager {
  ServerManager._privateConstructor();

  static final ServerManager _instance = ServerManager._privateConstructor();

  factory ServerManager() {
    return _instance;
  }

  // static const String _baseUrl = 'http://localhost:3001';
  // static const String _baseUrl = 'http://192.168.1.21:3001';
  static const String _baseUrl = 'https://gamify-273bac1e9487.herokuapp.com';

  var dio = Dio();
  // --------------------------------------------w

  // check request
  void checkRequest(Response response) {
    if (response.statusCode == 200) {
      // debugPrint(json.encode(response.data));
    } else {
      debugPrint(response.statusMessage);
    }
  }

  // ********************************************

  Future<UserModel?> login({
    required String email,
    required String password,
    bool isAutoLogin = false,
  }) async {
    try {
      var response = await dio.post(
        "$_baseUrl/login",
        data: {
          'email': email,
          'password': password,
        },
      );

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      if (isAutoLogin) return null;

      if (e.response?.statusCode == 404) {
        // Show error message to the user
        Helper().getMessage(
          status: StatusEnum.WARNING,
          message: 'Email not found',
        );
      } else if (e.response?.statusCode == 401) {
        // Show error message to the user
        Helper().getMessage(
          status: StatusEnum.WARNING,
          message: 'Incorrect password',
        );
      } else {
        // Handle other errors
        Helper().getMessage(
          status: StatusEnum.WARNING,
          message: 'An error occurred: ${e.message}',
        );
      }
      return null;
    }
  }

  Future<UserModel?> register({
    required String email,
    required String password,
  }) async {
    try {
      var response = await dio.post(
        "$_baseUrl/register",
        data: {
          'email': email,
          'password': password,
        },
      );

      checkRequest(response);

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        Helper().getMessage(
          status: StatusEnum.WARNING,
          message: 'User already exists',
        );
      } else {
        Helper().getMessage(
          status: StatusEnum.WARNING,
          message: 'An error occurred: ${e.message}',
        );
      }
      return null;
    }
  }

  // get user
  // TODO: auto login system
  Future<UserModel> getUser() async {
    var response = await dio.get(
      // TODO: user id shared pref den alınacak
      "$_baseUrl/getUser",
      queryParameters: {
        'user_id': loginUser!.id,
      },
    );

    checkRequest(response);

    return UserModel.fromJson(response.data[0]);
  }

  // get items
  Future<List<ItemModel>> getItems() async {
    var response = await dio.get(
      "$_baseUrl/getItems",
      queryParameters: {
        'user_id': loginUser!.id,
      },
    );

    checkRequest(response);

    return (response.data as List).map((e) => ItemModel.fromJson(e)).toList();
  }

  // get traits
  Future<List<TraitModel>> getTraits() async {
    var response = await dio.get(
      "$_baseUrl/getTraits",
      queryParameters: {
        'user_id': loginUser!.id,
      },
    );

    checkRequest(response);

    return (response.data as List).map((e) => TraitModel.fromJson(e)).toList();
  }

  // get routines
  Future<List<RoutineModel>> getRoutines() async {
    var response = await dio.get(
      "$_baseUrl/getRoutines",
      queryParameters: {
        'user_id': loginUser!.id,
      },
    );

    checkRequest(response);

    return (response.data as List).map((e) => RoutineModel.fromJson(e)).toList();
  }

  // get tasks
  Future<List<TaskModel>> getTasks() async {
    var response = await dio.get(
      "$_baseUrl/getTasks",
      queryParameters: {
        'user_id': loginUser!.id,
      },
    );

    checkRequest(response);

    return (response.data as List).map((e) => TaskModel.fromJson(e)).toList();
  }

// -------------------

// add user
  Future<int> addUser({
    required UserModel userModel,
  }) async {
    try {
      var response = await dio.post(
        "$_baseUrl/addUser",
        data: userModel.toJson(),
      );

      checkRequest(response);

      return response.data['id'];
    } on DioException catch (e) {
      debugPrint('Error adding user: ${e.message}');
      rethrow;
    }
  }

// add item
  Future<int> addItem({
    required ItemModel itemModel,
  }) async {
    try {
      var response = await dio.post(
        "$_baseUrl/addItem",
        queryParameters: {
          'user_id': loginUser!.id,
        },
        data: itemModel.toJson(),
      );

      checkRequest(response);

      return response.data['id'];
    } on DioException catch (e) {
      debugPrint('Error adding item: ${e.message}');
      rethrow;
    }
  }

// add trait
  Future<int> addTrait({
    required TraitModel traitModel,
  }) async {
    try {
      var response = await dio.post(
        "$_baseUrl/addTrait",
        queryParameters: {
          'user_id': loginUser!.id,
        },
        data: traitModel.toJson(),
      );

      checkRequest(response);

      return response.data['id'];
    } on DioException catch (e) {
      debugPrint('Error adding trait: ${e.message}');
      rethrow;
    }
  }

// add routine
  Future<int> addRoutine({
    required RoutineModel routineModel,
  }) async {
    try {
      var response = await dio.post(
        "$_baseUrl/addRoutine",
        queryParameters: {
          'user_id': loginUser!.id,
        },
        data: routineModel.toJson(),
      );

      checkRequest(response);

      return response.data['id'];
    } on DioException catch (e) {
      debugPrint('Error adding routine: ${e.message}');
      rethrow;
    }
  }

// add task
  Future<int> addTask({
    required TaskModel taskModel,
  }) async {
    var response = await dio.post(
      "$_baseUrl/addTask",
      queryParameters: {
        'user_id': loginUser!.id,
      },
      data: taskModel.toJson(),
    );

    checkRequest(response);

    return response.data['id'];
  }

  // ------------------------

  // update user
  Future<void> updateUser({
    required UserModel userModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/updateUser",
      data: userModel.toJson(),
    );

    checkRequest(response);
  }

  // update items
  Future<void> updateItem({
    required ItemModel itemModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/updateItem",
      data: itemModel.toJson(),
    );

    checkRequest(response);
  }

  // update trait
  Future<void> updateTrait({
    required TraitModel traitModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/updateTrait",
      data: traitModel.toJson(),
    );

    checkRequest(response);
  }

  // update routines
  Future<void> updateRoutine({
    required RoutineModel routineModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/updateRoutine",
      data: routineModel.toJson(),
    );

    checkRequest(response);
  }

  // update tasks
  Future<void> updateTask({
    required TaskModel taskModel,
  }) async {
    var response = await dio.put(
      "$_baseUrl/updateTask",
      data: taskModel.toJson(),
    );

    checkRequest(response);
  }

  // delete item
  Future<void> deleteItem({
    required int id,
  }) async {
    var response = await dio.delete(
      "$_baseUrl/deleteItem",
      queryParameters: {
        'item_id': id,
      },
    );

    checkRequest(response);
  }

  // delete trait
  Future<void> deleteTrait({
    required int id,
  }) async {
    var response = await dio.delete(
      "$_baseUrl/deleteTrait",
      queryParameters: {
        'trait_id': id,
      },
    );

    checkRequest(response);
  }

  // delete routine
  Future<void> deleteRoutine({
    required int id,
  }) async {
    var response = await dio.delete(
      "$_baseUrl/deleteRoutine",
      queryParameters: {
        'routine_id': id,
      },
    );

    checkRequest(response);
  }

  // delete task
  Future<void> deleteTask({
    required int id,
  }) async {
    var response = await dio.delete(
      "$_baseUrl/deleteTask",
      queryParameters: {
        'task_id': id,
      },
    );

    checkRequest(response);
  }

  // trigger tasks !!!!! normalde bu kullanılmıyor. 00:00 olduğunda otomatik backendde yapılıyor. test etmek için böyle koyuldu.
  Future<void> routineToTask() async {
    var response = await dio.post(
      "$_baseUrl/routineToTask",
    );

    checkRequest(response);
  }
}
