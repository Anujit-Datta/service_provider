import 'package:flutter/material.dart';

class launcherPage extends StatelessWidget {
  const launcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, (){
      Navigator.pushReplacementNamed(context, '/login');
      // if(AuthServices.currUser != null){
      //   Navigator.pushReplacementNamed(context, '/home');
      // }else{
      //   Navigator.pushReplacementNamed(context, '/login');
      // }
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
