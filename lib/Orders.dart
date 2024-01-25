import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:service_provider/Controllers/UserController.dart';
import 'package:service_provider/Controllers/providersController.dart';
List<Map<String,dynamic>> orders=[];
UserController controllerU=Get.find<UserController>();
ProvidersController controller=Get.find<ProvidersController>();
final _db=FirebaseFirestore.instance;
Future getOrders() async{
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
      .collection('Orders')
      .orderBy('date_time')
      .where('user', isEqualTo: controllerU.currUserModel.email)
      .get();
  orders = querySnapshot.docs.map((doc) => doc.data()).toList();
  orders=orders.reversed.toList();
  print(orders);
}