import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/routes.dart';
import 'package:service_provider/userModel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _db= FirebaseFirestore.instance;
  final _auth= FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorCode= '';

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
          key: _formKey,
          child: Stack(
            children: [
              createAccountText(),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            nameField(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            emailField(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            phoneField(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            addressField(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            passwordField(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: Text(errorCode,style: TextStyle(fontSize: 17,color: Colors.redAccent),),
                            ),
                            signupButton(),
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
            'Sign in',
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
              onPressed: () async{
                if (_formKey.currentState!.validate()){
                  final user= userModel(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      address: _addressController.text,
                      image: '',
                  );
                    await _auth
                        .createUserWithEmailAndPassword(email: user.email, password: _passwordController.text);
                    await _db
                        .collection('Users')
                        .doc(user.email)
                        .set(user.toMap()).onError((errorcode, stackTrace) {setState(() {errorCode=errorcode.toString();});})
                        .whenComplete(() => Navigator.pushReplacementNamed(context, userHomePageRoute));
                }
              },
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
      controller: _passwordController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.lightBlueAccent.shade100,
          prefixIcon: Icon(Icons.key,color: Colors.blueGrey.shade600,),
          labelText: 'Password',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
          )),
      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'Provide a password';
        }else if(value.length<6){
          return 'Password should be at least 6 characters';
        }
        return null;
      },
    );
  }

  TextFormField addressField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: _addressController,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.lightBlueAccent.shade100,
          prefixIcon: Icon(Icons.location_on),
          labelText: 'Address',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
          )),
      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'Provide your address';
        }
        return null;
      },
    );
  }

  TextFormField phoneField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.lightBlueAccent.shade100,
          prefixIcon: Icon(Icons.phone),
          labelText: 'Phone',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
          )),
      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'Provide your phone number';
        }else if(!RegExp(r"^(?:[+0][1-9])?[0-9]{9}$").hasMatch(value)){
          return 'Invalid phone number';
        }
        return null;
      },
    );
  }

  TextFormField emailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.lightBlueAccent.shade100,
          prefixIcon: Icon(Icons.email),
          labelText: 'Email',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
          )),
      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'Provide an email address';
        }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
          return 'Invalid email address';
        }
        return null;
      },
    );
  }

  TextFormField nameField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: _nameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.lightBlueAccent.shade100,
          prefixIcon: Icon(Icons.person),
          labelText: 'Username',
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(45),
          )),
      validator: (value) {
        if(value == null || value.isEmpty) {
          return 'Provide your name';
        }
        return null;
      },
    );
  }

  Container createAccountText() {
    return Container(
      padding: EdgeInsets.only(
          left: 35, top: MediaQuery.of(context).size.height * 0.10),
      child: Text(
        'Create\nAccount',
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
    );
  }
}
