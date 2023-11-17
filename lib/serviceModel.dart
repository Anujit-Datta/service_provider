import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_provider/userModel.dart';
int selectedServiceProvider=-1;

final _db=FirebaseFirestore.instance;

String? currUserDoc='';
bool currUserModelLoaded=false;
late userModel currUserModel;

Future getCurrUserModel()async {
  await _db.collection('Users').doc(currUserDoc).get().then((value) {
    currUserModel=userModel.fromMap(value.data() as Map<String,dynamic>);
    currUserModelLoaded=true;
  });
  
}