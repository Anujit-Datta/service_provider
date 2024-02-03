import 'package:cloud_firestore/cloud_firestore.dart';

class orderModel{
  String userEmail;
  DocumentReference? userReference;
  String providerEmail;
  DocumentReference? providerReference;
  String orderStatus;
  DateTime orderDateTime;
  String orderType;
  String orderSubType;

  orderModel({
    required this.userEmail,
    required this.userReference,
    required this.providerEmail,
    required this.providerReference,
    required this.orderStatus,
    required this.orderDateTime,
    required this.orderType,
    required this.orderSubType,
  });

  Map<String, dynamic> toMap(){
    final Map = <String, dynamic>{
      'user' : userEmail,
      'userRef' : userReference,
      'provider' : providerEmail,
      'providerRef' : providerReference,
      'status' : orderStatus,
      'date_time' : FieldValue.serverTimestamp(),
      'service' : orderType,
      'subType' : orderSubType,
    };
    return Map;
  }

  factory orderModel.fromMap(Map<String, dynamic> map) => orderModel(
    userEmail: map['user'],
    userReference: map['userRef'],
    providerEmail: map['provider'],
    providerReference: map['providerRef'],
    orderStatus: map['status'],
    orderDateTime: map['date_time'].toDate(),
    orderType: map['service'],
    orderSubType: map['subType'],
  );


}