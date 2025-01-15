import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gamify_todo/2%20General/accessible.dart';
import 'package:gamify_todo/2%20General/app_colors.dart';
import 'package:gamify_todo/2%20General/init_app.dart';
import 'package:gamify_todo/3%20Page/Login/login_page.dart';
import 'package:gamify_todo/3%20Page/navbar_page_manager.dart';
import 'package:gamify_todo/5%20Service/product_localization.dart';
import 'package:gamify_todo/6%20Provider/add_store_item_providerr.dart';
import 'package:gamify_todo/6%20Provider/add_task_provider.dart';
import 'package:gamify_todo/6%20Provider/navbar_provider.dart';
import 'package:gamify_todo/6%20Provider/store_provider.dart';
import 'package:gamify_todo/6%20Provider/task_provider.dart';
import 'package:gamify_todo/6%20Provider/trait_provider.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  await initApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NavbarProvider()),
      ChangeNotifierProvider(create: (context) => TaskProvider()),
      ChangeNotifierProvider(create: (context) => StoreProvider()),
      ChangeNotifierProvider(create: (context) => AddTaskProvider()),
      ChangeNotifierProvider(create: (context) => AddStoreItemProvider()),
      ChangeNotifierProvider(create: (context) => TraitProvider()),
    ],
    child: ProductLocalization(child: const Main()),
  ));
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2400),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'NextLevel',
          theme: AppColors().appTheme,
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          home: loginUser != null ? const NavbarPageManager() : const LoginPage(),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
