import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:service_provider/Pages/launcher.dart';
import '../Models/orderModel.dart';
import '../Pages/selectedServiceInfo.dart';


class OrderController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  bool historyProgressVisibility=true;
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

  postOrder(orderModel order) async {
    await _db.collection('Orders').add(order.toMap()).whenComplete(() {
      visibility=false;
      update();
    });
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
