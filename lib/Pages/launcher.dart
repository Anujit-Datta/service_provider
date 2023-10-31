import 'package:flutter/material.dart';
import 'package:service_provider/firebaseHelper.dart';
import 'package:service_provider/routes.dart';

class launcherPage extends StatelessWidget {
  const launcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, (){
      if(AuthServices.currentUser != null){
        Navigator.pushReplacementNamed(context, userHomePageRoute);
      }else{
        Navigator.pushReplacementNamed(context, loginRoute);
      }
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
