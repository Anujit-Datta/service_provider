import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/Controllers/providersController.dart';
import 'package:service_provider/Pages/services.dart';

class selectedServiceInfo extends StatelessWidget {
  const selectedServiceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    ProvidersController controller= Get.find<ProvidersController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Color(0xff4c505b),
          onPressed: (){
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
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: GetBuilder<ProvidersController>(builder: (_){
              return ListView(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.37,
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.35,
                      foregroundImage: NetworkImage(
                        Providers[controller.selectedServiceProvider].image,
                      ),
                      //backgroundImage: ,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      controller.providers[controller.selectedServiceProvider].name,
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
                              controller.providers[controller.selectedServiceProvider].type,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            dense: true,
                            onTap: (){} ,
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
                              controller.providers[controller.selectedServiceProvider].address,
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
                              controller.providers[controller.selectedServiceProvider].score.toString() +
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
            },)
          ),
          Container(
            height: 50,
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  color: Colors.lightBlueAccent,
                  child: Text(
                    'Reviews ',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width*0.1,),
                MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
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
        ],
      ),
    );
  }
}
