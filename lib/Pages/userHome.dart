import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/routes.dart';

class userHomePage extends StatelessWidget {
  const userHomePage({super.key});
  static final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Home Page'),
            ElevatedButton(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushReplacementNamed(context, launcherRoute);
                },
                child: Text('Logout')),
          ],
        ),
      ),
    );
  }
}
