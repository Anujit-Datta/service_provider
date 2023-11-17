import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProvidersController extends GetxController{
  final _db=FirebaseFirestore.instance;

  int itemsAmount=0;
  int currService=-1;
  bool isLoaded = false;
  List services = ['Electrician', 'Plumber', 'Cleaner', 'Painter', 'ISP'];
  late List<Map<String, dynamic>> providers;
  providersInfoGetter() async {
    itemsAmount = 0;
    List<Map<String, dynamic>> templist = [];
    var snap = await _db.collection(services[currService]).get();
    snap.docs.forEach((element) {
      templist.add(element.data());
      itemsAmount += 1;
    });
    isLoaded = true;
    providers = templist;
    update();
  }


}