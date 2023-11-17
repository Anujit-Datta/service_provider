import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:service_provider/Pages/Register.dart';
import 'package:service_provider/Pages/login.dart';

class forgotPassword extends StatefulWidget {
  const forgotPassword({super.key});

  @override
  State<forgotPassword> createState() => _forgotPasswordState();
}

class _forgotPasswordState extends State<forgotPassword> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _resetMsg = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login.png"),
            fit: BoxFit.cover,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              ForgotPasswordText(),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.45,
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Column(
                    children: [
                      email_field(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Reset_text_and_Button(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.13,
                        child: Text(
                          _resetMsg,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Register_ask(),
                      Login_ask(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static final _auth = FirebaseAuth.instance;

  void validation() async {
    EasyLoading.show(status: 'Logging in', dismissOnTap: false);
    try {
      final email = _emailController.text;
      await _auth.sendPasswordResetEmail(email: email).onError((error, stackTrace) {
        EasyLoading.dismiss();
        setState(() {
          _resetMsg = error.toString();
        });
      }).whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _resetMsg= 'Password Reset link sent to email\nNote: Check Spam folder also';
        });
      });
    } on FirebaseAuthException catch (error) {
      EasyLoading.dismiss();
      setState(() {
        _resetMsg = error.message.toString();
      });
    }
  }

  Container ForgotPasswordText() {
    return Container(
      padding: EdgeInsets.only(
          left: 10, top: MediaQuery.of(context).size.height * 0.11),
      child: Text(
        'Reset\nPassword',
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
    );
  }

  TextFormField email_field() {
    return TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          fillColor: Colors.lightBlueAccent.shade100,
          filled: true,
          prefixIcon: Icon(Icons.email),
          labelText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Provide an email address';
          } else if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return 'Invalid email address';
          }
          return null;
        });
  }

  Row Reset_text_and_Button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            "Reset",
            style: TextStyle(
                color: Color(0xff4c505b),
                fontSize: 35,
                fontWeight: FontWeight.w700),
          ),
          padding: EdgeInsets.only(left: 20,bottom: 10),
        ),
        Container(
          padding: EdgeInsets.only(right: 15,bottom: 15),
          child: CircleAvatar(
            backgroundColor: Color(0xff4c505b),
            radius: 35,
            child: IconButton(
              onPressed: validation,
              color: Colors.white,
              icon: Icon(Icons.arrow_forward),
            ),
          ),
        ),
        //ElevatedButton(onPressed: onPressed, child: child)
      ],
    );
  }

  SizedBox Register_ask() {
    return SizedBox(
          height: 40,
          width: 100,
          child: TextButton(
            onPressed: () {
              Get.to(RegisterPage());
            },
            child: Text(
              'Sign up',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff4c505b),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        );
  }

  SizedBox Login_ask() {
    return SizedBox(
      height: 40,
      width: 100,
      child: TextButton(
        onPressed: () {Get.to(LoginPage());},
        child: Text(
          "Sign in",
          style: TextStyle(
            fontSize: 18,
            color: Color(0xff4c505b),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

}
