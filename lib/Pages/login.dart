import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        body: Stack(
          children: [
            //Welcome_text(),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Password_field(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Login_text_and_Button(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.14,
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
    );
  }



  TextField email_field() {
    return TextField(
      decoration: InputDecoration(
        fillColor: Colors.lightBlueAccent.shade100,
        filled: true,
        hintText: " Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  TextField Password_field() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        fillColor: Colors.lightBlueAccent.shade100,
        filled: true,
        hintText: " Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Row Login_text_and_Button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            "Login",
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
            child: IconButton(
              onPressed: () {},
              color: Colors.white,
              icon: Icon(Icons.arrow_forward),
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
          height: 30,
          width: 70,
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/register');
            },
            child: Text(
              'Register',
              style: TextStyle(
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
      height: 35,
      child: TextButton(
        onPressed: (){},
        child: Text(
          "Forgot Password?",
          style: TextStyle(
              color: Color(0xff4c505b),
              decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

}
