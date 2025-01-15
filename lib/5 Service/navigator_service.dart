import 'package:flutter/material.dart';
import 'package:gamify_todo/3%20Page/Login/login_page.dart';
import 'package:gamify_todo/5%20Service/home_widget_service.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigatorService {
  static final NavigatorService _instance = NavigatorService._internal();
  factory NavigatorService() => _instance;
  NavigatorService._internal();

  Future<dynamic> goTo(
    Widget page, {
    Transition? transition,
  }) async {
    await Get.to(
      page,
      transition: transition ?? Transition.native,
      fullscreenDialog: true,
    );
  }

  void goBack() {
    Get.back();
  }

  void goBackAll() {
    Get.until((route) {
      if (route.settings.name == "/NavbarPageManager") {
        return true;
      } else if (route.settings.name == "/" || route.settings.name == null) {
        return true;
      }
      return false;
    });
  }

  // delete mail and password on shared preferences and go to login page
  void logout() async {
    // SharedPreferences
    HomeWidgetService.resetHomeWidget();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('password');
    Get.offUntil(
      GetPageRoute(
        page: () => const LoginPage(),
      ),
      (route) => false,
    );
  }
}



// ! veri gönder
// Get.toNamed('/second', arguments: {
//   'name': 'Joseph Onalo',
//   'age': 24,
// });

// ! veri al
// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final name = Get.arguments['name'];
//     final age = Get.arguments['age'];

// Get.to('/second');
// Get.to(()=>const SecondScreen());

// Get.back();

// Belirli bir rotaya gitme
// Get.offAllNamed('/first');

// Mevcut rotanın üzerine yeni bir rota itme
// Get.toNamed('/third');

// Bilinen mevcut rotanın üzerine yeni bir rota itme
// Get.toNamed('/second/third');

// Get.to(NextScreen());
// Navigate to new screen with name. See more details on named routes here

// Get.toNamed('/details');
// To close snackbars, dialogs, bottomsheets, or anything you would normally close with Navigator.pop(context);

// Get.back();
// To go to the next screen and no option to go back to the previous screen (for use in SplashScreens, login screens, etc.)

// Get.off(NextScreen());
// To go to the next screen and cancel all previous routes (useful in shopping carts, polls, and tests)

// Get.offAll(NextScreen());