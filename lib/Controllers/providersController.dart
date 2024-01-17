import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:service_provider/providerModel.dart';
import '../Pages/services.dart';
import '../Pages/userHome.dart';

class ProvidersController extends GetxController{
  final _db=FirebaseFirestore.instance;

  var selectedServiceProvider=-1;
  int currService=-1;

  List<providerModel> providers=[];

  Future providersInfoGetter() async {
    providers=[];
    itemsAmount=0;
    await _db.collection(services[currService]).get().then((value) {
      value.docs.forEach((element) {
        providers.add(providerModel.fromMap(element.data()));
        itemsAmount<providers.length?itemsAmount+=1:itemsAmount+=0;
      });
      isLoaded=true;
      update();
    });
  }

  currServiceSetter(int x){
    currService=x;
    update();
  }


  selectedSetter(int x){
    selectedServiceProvider=x;
    update();
  }


}