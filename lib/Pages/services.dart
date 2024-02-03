import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:service_provider/Controllers/providersController.dart';
import 'package:service_provider/Pages/selectedServiceInfo.dart';
import 'package:service_provider/Pages/userHome.dart';
import 'package:service_provider/Models/providerModel.dart';
List<providerModel> Providers=[];
bool isLoaded = false;
int itemsAmount=0;


class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    ProvidersController controller= Get.find<ProvidersController>();

    controller.providersInfoGetter().then((value) {
      Providers=[];
      Providers=controller.providers;
    });
    return GetBuilder<ProvidersController>(builder: (_){
      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xff4c505b),
              size: 30,
            ),
            onPressed: (){isLoaded=false;Get.back();},
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 1,
              ),
              Text(
                services[controller.currService == -1 ? 0 : controller.currService] + 's',
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
        body: isLoaded == true
            ? Providers.length>0? _body(context)
            : _noDataFound(controller)
            : _loading(),
      );
    },);
  }

   _body(BuildContext context){
    ProvidersController controller= Get.find<ProvidersController>();
    EasyLoading.dismiss();
    print(Providers.length.toString()+" "+itemsAmount.toString()+' '+controller.providers.length.toString());
    return ListView.builder(
      itemCount: itemsAmount,
      itemBuilder: (BuildContext, int index) {
        return GestureDetector(
          onTap: (){
            controller.selectedSetter(index);
            Get.to(()=>selectedServiceInfo(),arguments: index);
          },
          child: Container(
            height: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(65),
              ),
              elevation: 7,
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: CircularProgressIndicator(),
                      foregroundImage: NetworkImage(
                        Providers[index].image==''?'https://firebasestorage.googleapis.com/v0/b/service-provider-2798f.appspot.com/o/user-male-circle.png?alt=media&token=f95cd854-6136-4118-94cd-4abfb3f48656':Providers[index].image,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: MediaQuery.of(context).orientation==Orientation.portrait?2:5,
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 5,bottom: 12,top: 10),
                        child: Text(
                          Providers[index].name,
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
                                Providers[index].type,
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
                                Providers[index].address,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),

                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },);
  }

  Widget _noDataFound(ProvidersController controller){
    EasyLoading.dismiss();
    return Center(
      child: Text(
        "No " +services[controller.currService]+ " found nearby",
        style: TextStyle(
            fontSize: 20
        ),
      ),
    );
  }

  Widget _loading(){
    return Center(child: CircularProgressIndicator());
  }
}
