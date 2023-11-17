import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:service_provider/Controllers/providersController.dart';
import 'package:service_provider/Pages/selectedServiceInfo.dart';
import 'package:service_provider/serviceModel.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {

  @override
  Widget build(BuildContext context) {
    ProvidersController controller= Get.find<ProvidersController>();
    controller.providersInfoGetter();
    return GetBuilder<ProvidersController>(builder: (_){
      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xff4c505b),
                size: 30,
              ),
              onPressed: (){controller.isLoaded=false;Get.back();},
            );
          }),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 1,
              ),
              Text(
                controller.services[controller.currService == -1 ? 0 : controller.currService] + 's',
                style: TextStyle(
                  fontSize: 35,
                  color: Color(0xff4c505b),
                ),
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: () {},
                  color: Color(0xff4c505b),
                  icon: Icon(
                    Icons.edit_location_alt,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: controller.isLoaded == true
            ? controller.itemsAmount>0? _body()
            : _noDataFound(controller)
            : _loading(),
      );
    },);
  }

  Widget _body(){
    ProvidersController controller= Get.find<ProvidersController>();
    EasyLoading.dismiss();
    return ListView.builder(
        itemCount: controller.itemsAmount,
        itemBuilder: (BuildContext, int index) {
          return GestureDetector(
            onTap: (){
              selectedServiceProvider=index;
              print(selectedServiceProvider);
              Get.to(()=>selectedServiceInfo());
            },
            child: Container(
              height: 150,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 7,
                margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          controller.providers[index]['image'].toString()==''?'https://firebasestorage.googleapis.com/v0/b/service-provider-2798f.appspot.com/o/user-male-circle.png?alt=media&token=f95cd854-6136-4118-94cd-4abfb3f48656':controller.providers[index]['image'].toString(),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: MediaQuery.of(context).orientation==Orientation.portrait?2:5,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 5,bottom: 12,top: 10),
                          child: Text(
                            controller.providers[index]['name'].toString(),
                            style: TextStyle(
                              color: Colors.lightBlueAccent.shade700,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.label_important_outlined,
                                  size: 20,
                                ),
                                Text(
                                  controller.providers[index]['type'].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 20,
                                ),
                                Text(
                                  controller.providers[index]['address'].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.arrow_forward_ios,),
                          ],
                        ),
                        onTap: () {
                          selectedServiceProvider=index;
                          print(selectedServiceProvider);
                          Get.to(()=>selectedServiceInfo());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _noDataFound(ProvidersController controller){
    EasyLoading.dismiss();
    return Center(
      child: Text(
        "No" +controller.services[controller.currService]+ "found nearby",
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }

  Widget _loading(){
    EasyLoading.show(status: 'Fetching Data');
    return Center(child: Text(''),);
  }
}
