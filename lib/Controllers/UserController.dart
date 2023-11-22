import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../userModel.dart';

class UserController extends GetxController {
  final _db=FirebaseFirestore.instance;
  String? currUserDoc='';
  late userModel currUserModel;

  Future getCurrUserModel() async {
    await _db.collection('Users').doc(currUserDoc).get().then((value) {
      currUserModel = userModel.fromMap(value.data() as Map<String, dynamic>);
      update();
    });
  }

  String _resetMsg = '';
  String get resetMsg => _resetMsg;
  resetMsgSetter(String msg){
    _resetMsg=msg;
    update();
  }

}