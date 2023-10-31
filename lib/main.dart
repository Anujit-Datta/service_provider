  import 'package:flutter/material.dart';
  import 'package:flutter_easyloading/flutter_easyloading.dart';
  import 'package:service_provider/Pages/launcher.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:service_provider/routes.dart';
  import 'firebase_options.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  }
  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: appRoutes,
        title: 'Flutter Demo',
        builder: EasyLoading.init(),
        home: const launcherPage(),
      );
    }
  }
