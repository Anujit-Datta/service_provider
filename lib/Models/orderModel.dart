import 'package:cloud_firestore/cloud_firestore.dart';

class orderModel{
  String userEmail;
  String providerEmail;
  String orderStatus;
  DateTime orderDateTime;
  String orderType;
  String orderSubType;
  String? otp;

  orderModel({
    required this.userEmail,
    required this.providerEmail,
    required this.orderStatus,
    required this.orderDateTime,
    required this.orderType,
    required this.orderSubType,
    this.otp,
  });

  Map<String, dynamic> toMap(){
    final Map = <String, dynamic>{
      'user' : userEmail,
      'provider' : providerEmail,
      'status' : orderStatus,
      'date_time' : FieldValue.serverTimestamp(),
      'service' : orderType,
      'subType' : orderSubType,
      'otp' : otp,
    };
    return Map;
  }

  factory orderModel.fromMap(Map<String, dynamic> map) => orderModel(
    userEmail: map['user'],
    providerEmail: map['provider'],
    orderStatus: map['status'],
    orderDateTime: map['date_time'].toDate(),
    orderType: map['service'],
    orderSubType: map['subType'],
    otp: map['otp'],
  );


}