import 'package:discuss_app/config/app_color.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:discuss_app/controller/c_home.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CUser()),
        ChangeNotifierProvider(create: (_) => CHome()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColor.primary,
          colorScheme: const ColorScheme.light().copyWith(
            primary: AppColor.primary,
            secondary: AppColor.primary,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: AppColor.primary,
            foregroundColor: Colors.white,
          ),
        ),
        routerConfig: AppRoute.routerConfig,
      ),
    );
  }
}
