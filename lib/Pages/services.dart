import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:service_provider/routes.dart';
import 'package:service_provider/serviceModel.dart';
import 'userHome.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  late List<Map<String, dynamic>> items;
  dynamic itemsAmount = 0;
  bool isLoaded = false;
  final _db = FirebaseFirestore.instance;
  counter() async {
    itemsAmount = 0;
    List<Map<String, dynamic>> templist = [];
    var data = await _db.collection(serviceName).get();
    data.docs.forEach((element) {
      templist.add(element.data());
      itemsAmount += 1;
    });
    setState(() {
      items = templist;
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    isLoaded == false ? counter() : print(itemsAmount);
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
            onPressed: (){Navigator.pop(context);},
          );
        }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 1,
            ),
            Text(
              services[currService == -1 ? 0 : currService] + 's',
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
          ? itemsAmount>0? _body()
          : _noDataFound()
          : _loading(),
    );
  }

  Widget _body(){
    EasyLoading.dismiss();
    return ListView.builder(
        itemCount: itemsAmount,
        itemBuilder: (BuildContext, int index) {
          return Container(
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
                        items[index]['image'].toString()==''?'https://img.icons8.com/ios-filled/100/user-male-circle.png':items[index]['image'].toString(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 15,bottom: 12,top: 10),
                        child: Text(
                          items[index]['name'].toString(),
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
                                items[index]['type'].toString(),
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
                                items[index]['address'].toString(),
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
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _noDataFound(){
    EasyLoading.dismiss();
    return Center(
      child: Text(
        'No $serviceName found nearby',
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
