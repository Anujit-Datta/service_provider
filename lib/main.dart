  import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
  import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:service_provider/Controllers/OrderController.dart';
  import 'package:service_provider/Pages/launcher.dart';
  import 'package:firebase_core/firebase_core.dart';
import 'Controllers/providersController.dart';
import 'firebase_options.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  }
  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      Get.put(ProvidersController());
      Get.put(OrderController());
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        builder: EasyLoading.init(),
        home: const launcherPage(),
      );
    }
  }
