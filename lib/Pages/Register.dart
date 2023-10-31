  import 'package:flutter/material.dart';

  class RegisterPage extends StatefulWidget {
    const RegisterPage({Key? key}) : super(key: key);

    @override
    State<RegisterPage> createState() => _RegisterPageState();
  }

  class _RegisterPageState extends State<RegisterPage> {
    @override
    Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/register.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            child: Stack(
              children: [
                createAccountText(),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              nameField(),
                              SizedBox(
                                height: 15,
                              ),
                              emailField(),
                              SizedBox(
                                height: 15,
                              ),
                              phoneField(),
                              SizedBox(
                                height: 15,
                              ),
                              addressField(),
                              SizedBox(
                                height: 15,
                              ),
                              passwordField(),
                              SizedBox(
                                height: 20
                                ,
                              ),
                              signupButton(),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              signinAsk(context)
                            ],
                          ),
                        )
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

    Row signinAsk(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Already have an account? ',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text(
              'Sign In',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color(0xff4c505b),
                  fontSize: 20),
            ),
            style: ButtonStyle(),
          ),
        ],
      );
    }

    Row signupButton() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Sign Up',
            style: TextStyle(
                color: Colors.white, fontSize: 27, fontWeight: FontWeight.w700),
          ),
          CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xff4c505b),
            child: IconButton(
                color: Colors.white,
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward,
                )),
          )
        ],
      );
    }

    TextFormField passwordField() {
      return TextFormField(
        style: TextStyle(color: Colors.white),
        obscureText: true,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.lightBlueAccent.shade100,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
            )),
      );
    }

    TextFormField addressField() {
      return TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.lightBlueAccent.shade100,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
            )),
      );
    }

    TextFormField phoneField() {
      return TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.lightBlueAccent.shade100,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            hintText: "Phone",
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
            )),
      );
    }

    TextFormField emailField() {
      return TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.lightBlueAccent.shade100,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
            )),
      );
    }

    TextFormField nameField() {
      return TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
              borderSide: BorderSide(
                color: Colors.blueGrey,
              ),
            ),
            hintText: "Name",
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(45),
            )),
      );
    }

    Container createAccountText() {
      return Container(
        padding: EdgeInsets.only(left: 35,top: 35),
        child: Text(
          'Create\nAccount',
          style: TextStyle(color: Colors.white, fontSize: 45),
        ),
      );
    }
  }
