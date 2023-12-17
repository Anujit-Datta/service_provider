import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:service_provider/Pages/Register.dart';
import 'package:service_provider/Pages/forgotpassword.dart';
import 'package:service_provider/Pages/launcher.dart';
import 'package:service_provider/firebaseHelper.dart';

import '../Controllers/UserController.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode one=FocusNode();
  final _emailController = TextEditingController();
  FocusNode two=FocusNode();
  final _passwordController = TextEditingController();
  FocusNode three=FocusNode();
  final _formKey = GlobalKey<FormState>();
  String _errorMsg = '';
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
              LoginText(),
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
                      Password_field(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Login_text_and_Button(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.13,
                        child: Text(
                          _errorMsg,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Register_ask(),
                      forgot_password(),
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
      final password = _passwordController.text;
      final status = await AuthServices.loginto(email, password);
      if (status) {
        EasyLoading.dismiss();
        Get.to(() =>launcherPage());
      } else {
        await _auth.signOut();
      }
    } on FirebaseAuthException catch (error) {
      EasyLoading.dismiss();
      setState(() {
        _errorMsg = error.message.toString();
      });
    }
  }

  Container LoginText() {
    return Container(
      padding: EdgeInsets.only(
          left: 10, top: MediaQuery.of(context).size.height * 0.15),
      child: Text(
        'Welcome',
        style: TextStyle(color: Colors.white, fontSize: 60),
      ),
    );
  }


  TextFormField email_field() {
    return TextFormField(
        controller: _emailController,
        focusNode: one,
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
        },
        onFieldSubmitted: (value){FocusScope.of(context).requestFocus(two);},
        );
  }

  TextFormField Password_field() {
    return TextFormField(
      controller: _passwordController,
      focusNode: two,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.key,color: Colors.blueGrey.shade600,),
        labelText: 'Password',
        fillColor: Colors.lightBlueAccent.shade100,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'Provide a password';
        }else if(value.length<6){
          return 'Minimum 6 characters';
        }
        return null;
      },
      onFieldSubmitted: (value){_formKey.currentState!.validate()?validation():FocusScope.of(context).requestFocus(three);},
    );
  }

  Row Login_text_and_Button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            "Sign In",
            style: TextStyle(
                color: Color(0xff4c505b),
                fontSize: 30,
                fontWeight: FontWeight.w700),
          ),
          padding: EdgeInsets.only(left: 20),
        ),
        Container(
          padding: EdgeInsets.only(right: 15),
          child: CircleAvatar(
            backgroundColor: Color(0xff4c505b),
            radius: 35,
            child: GestureDetector(
              child: IconButton(
                focusNode: three,
                onPressed: validation,
                color: Colors.white,
                icon: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ),
        //ElevatedButton(onPressed: onPressed, child: child)
      ],
    );
  }

  Row Register_ask() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            color: Color(0xff4c505b),
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 40,
          width: 70,
          child: TextButton(
            onPressed: () {
              Get.to(() =>RegisterPage());
            },
            child: Text(
              'Sign up',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff4c505b),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  SizedBox forgot_password() {
    return SizedBox(
      height: 40,
      child: TextButton(
        onPressed: () {Get.find<UserController>().resetMsgSetter('');Get.to(() =>forgotPassword());},
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            fontSize: 15,
            color: Color(0xff4c505b),
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
