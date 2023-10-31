import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'userModel.dart';

class AuthServices{
    static final _auth = FirebaseAuth.instance;

    static User? get currentUser => _auth.currentUser;

    static Future<bool> loginto(String email, String password) async{
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user != null;
    }





  }