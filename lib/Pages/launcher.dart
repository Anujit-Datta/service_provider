import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/Controllers/UserController.dart';
import 'package:service_provider/Pages/login.dart';
import 'package:service_provider/Pages/userHome.dart';
import 'package:service_provider/firebaseHelper.dart';
import '../Controllers/providersController.dart';

class launcherPage extends StatelessWidget {
  const launcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController controllerU=Get.put(UserController());
    Future.delayed(Duration.zero, (){
      if(AuthServices.currentUser != null){
        controllerU.currUserDoc=AuthServices.currentUser?.email.toString();
        Get.to(() =>userHomePage());
      }else{
        Get.to(() =>LoginPage());
      }
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
