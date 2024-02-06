import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/Controllers/OrderController.dart';
import 'package:service_provider/Controllers/UserController.dart';
import 'package:service_provider/Controllers/providersController.dart';
import 'package:service_provider/Models/orderModel.dart';
import 'package:service_provider/Models/providerModel.dart';
import 'package:service_provider/Pages/services.dart';
import 'package:service_provider/Pages/userHome.dart';
ProvidersController controller = Get.find<ProvidersController>();


class selectedServiceInfo extends StatefulWidget {
  const selectedServiceInfo({super.key});

  @override
  State<selectedServiceInfo> createState() => _selectedServiceInfoState();
}

class _selectedServiceInfoState extends State<selectedServiceInfo> {
  @override
  void initState() {
    Get.find<OrderController>().bookButtonVisibility();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Color(0xff4c505b),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Provider's Info",
          style: TextStyle(
            fontSize: 35,
            color: Color(0xff4c505b),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
              //height: MediaQuery.of(context).size.height * 0.85,
              child: GetBuilder<ProvidersController>(
                builder: (_) {
                  return ListView(
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.36,
                        foregroundColor: Colors.lightBlueAccent,
                        backgroundColor: Colors.lightBlueAccent,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.35,
                          backgroundColor: Colors.lightBlueAccent,
                          foregroundImage: NetworkImage(
                            Providers[controller.selectedServiceProvider]
                                        .image ==
                                    ''
                                ? 'https://firebasestorage.googleapis.com/v0/b/service-provider-2798f.appspot.com/o/user-male-circle.png?alt=media&token=f95cd854-6136-4118-94cd-4abfb3f48656'
                                : Providers[controller.selectedServiceProvider]
                                    .image,
                          ),
                          //backgroundImage: ,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          controller
                              .providers[controller.selectedServiceProvider]
                              .name,
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 80),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                    child: Icon(
                                  Icons.label_important_outlined,
                                  color: Colors.grey,
                                )),
                                horizontalTitleGap: 5,
                                minLeadingWidth: 20,
                                title: Text(
                                  controller
                                      .providers[
                                          controller.selectedServiceProvider]
                                      .type,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                dense: true,
                                onTap: () {},
                              ),
                              ListTile(
                                leading: Container(
                                    child: Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                )),
                                horizontalTitleGap: 5,
                                minLeadingWidth: 20,
                                title: Text(
                                  controller
                                      .providers[
                                          controller.selectedServiceProvider]
                                      .address,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                dense: true,
                              ),
                              ListTile(
                                leading: Container(
                                    child: Icon(
                                  Icons.work_history,
                                  color: Colors.grey,
                                )),
                                horizontalTitleGap: 5,
                                minLeadingWidth: 20,
                                title: Text(
                                  controller
                                          .providers[controller
                                              .selectedServiceProvider]
                                          .score
                                          .toString() +
                                      ' Serves',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                dense: true,
                              ),
                              ListTile(
                                leading: Container(
                                    child: Icon(
                                  Icons.attach_money,
                                  color: Colors.grey,
                                )),
                                horizontalTitleGap: 5,
                                minLeadingWidth: 20,
                                title: Text(
                                  '4.3 Rated',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                dense: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )),
          GetBuilder<OrderController>(
            builder: (oController) {
              return Visibility(
                visible: oController.visibility,
                replacement: Expanded(flex:2,child: SizedBox(height: MediaQuery.of(context).size.height * 0.1,)),
                child: Expanded(
                  flex: 2,
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Colors.lightBlueAccent,
                          child: Text(
                            '  Book  ',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  void createOrder() {
    final _db = FirebaseFirestore.instance;
    UserController controllerU=Get.find<UserController>();
    ProvidersController controller=Get.find<ProvidersController>();
    providerModel selectedProvider=controller.providers[Get.arguments];
    orderModel order = orderModel(
        userEmail: controllerU.currUserModel.email,
        userReference: _db.collection('Users').doc(controllerU.currUserModel.email),
        providerEmail: selectedProvider.email,
        providerReference: _db.collection(services[controller.selectedServiceProvider]).doc(selectedProvider.email),
        orderStatus: 'Pending',
        orderDateTime: DateTime.now(),
        orderType: services[controller.selectedServiceProvider],
        orderSubType: selectedProvider.type);
    Get.find<OrderController>().postOrder(order);

  }
}
