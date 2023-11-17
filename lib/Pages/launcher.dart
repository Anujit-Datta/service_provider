import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/Pages/login.dart';
import 'package:service_provider/Pages/userHome.dart';
import 'package:service_provider/firebaseHelper.dart';
import 'package:service_provider/serviceModel.dart';

class launcherPage extends StatelessWidget {
  const launcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, (){
      if(AuthServices.currentUser != null){
        currUserDoc=AuthServices.currentUser?.email.toString();
        Get.to(userHomePage());
      }else{
        Get.to(LoginPage());
      }
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
