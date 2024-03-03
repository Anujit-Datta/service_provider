import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:service_provider/Models/providerModel.dart';
import 'package:service_provider/Models/userModel.dart';
import 'package:service_provider/Pages/launcher.dart';
import '../Models/orderModel.dart';
import '../Pages/selectedServiceInfo.dart';
import 'package:http/http.dart' as http;


class OrderController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  bool historyProgressVisibility=true;
  void historyProgressVisibilitySetter(bool value){
    historyProgressVisibility=value;
    update();
  }
  List<orderModel> history = [];
  List<orderModel> requestedOrders = [];
  Future<void> getHistory() async {
    await _db
        .collection('Orders')
        .orderBy('date_time')
        .where(loginType == true ? 'user' : 'provider',
            isEqualTo: _auth.currentUser!.email)
        .get()
        .then((value) {
      history.clear();
      requestedOrders.clear();
      value.docs.forEach((element) {
        history.insert(0, orderModel.fromMap(element.data()));
        if (element.data()['status'] == 'Pending' ||
            element.data()['status'] == 'Running') {
          requestedOrders.add(history[0]);
        }
      });
      historyProgressVisibility=false;
      update();
      print('invoked');
    });
    //var dsfgbv=await _db.collection('').doc('');
    // var asdoivbh=await _db.collection('Users').get();
    // var bddb=asdoivbh.docs.map((DocumentSnapshot e) => e.reference).toList();
  }

  Future postOrder(orderModel order) async {
    await _db.collection('Orders').add(order.toMap()).whenComplete(() {
      visibility=false;
      update();
    });
  }

  Future orderPlacingNotifier(orderModel order,providerModel provider) async{
    Uri url=Uri.parse('https://fcm.googleapis.com/fcm/send');
    var notificationMsg={
      'to': provider.deviceToken,
      'priority':'high',
      'notification': {
        'title':'Hello ${provider.name}',
        'body':'You got a new order on our app.',
      }
    };
    await http.post(
      url,
      body: jsonEncode(notificationMsg),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=AAAA9SpLlhs:APA91bGX9Ny4IwWVlyDZs-rwVKBHcnUb95JY53VakLaV25xj7IBuYDcP5ff7dWRt5fBu62HsPsChroNUn249UguX_6esuZkjgFFRuh8eM89jt4Uu71hEt-fxlz6RTU9OFF-ZgyoQ8hYm',
      },
    );
  }

  Future orderConfirmingNotifier(orderModel order,userModel user) async{
    Uri url=Uri.parse('https://fcm.googleapis.com/fcm/send');
    var notificationMsg={
      'to': user.deviceToken,
      'priority':'high',
      'notification': {
        'title':'Hello ${user.name}',
        'body':'You order got accepted.',
      }
    };
    await http.post(
      url,
      body: jsonEncode(notificationMsg),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=AAAA9SpLlhs:APA91bGX9Ny4IwWVlyDZs-rwVKBHcnUb95JY53VakLaV25xj7IBuYDcP5ff7dWRt5fBu62HsPsChroNUn249UguX_6esuZkjgFFRuh8eM89jt4Uu71hEt-fxlz6RTU9OFF-ZgyoQ8hYm',
      },
    );
  }

  bool visibility=true;
  bool progressVisibility=true;
  String selectedProviderOrderStatus='';
  Future<void> bookButtonVisibility() async {
    print('invoked');
    await FirebaseFirestore.instance.collection('Orders').where('user' ,isEqualTo: controllerU.currUserModel.email ).where('provider',isEqualTo: controller.providers[controller.selectedServiceProvider].email).get().then((value) {
      bool willBreak=false;
      if(value.docs.length!=0){
        value.docs.forEach((element) {
          if (!willBreak) {
            if ((element['status'] == 'Pending' ||
                element['status'] == 'Running')) {
              selectedProviderOrderStatus = element['status'];
              visibility = false;
              print('booked2');
              willBreak = true;
            } else {
              visibility = true;
              print('not booked');
            }
          }
        });
      }else{
        visibility = true;
        print('not booked');
      }
      update();
    });
  }
}
