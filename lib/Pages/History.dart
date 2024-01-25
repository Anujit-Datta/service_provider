import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/Controllers/UserController.dart';
import 'package:service_provider/Controllers/providersController.dart';
import 'package:service_provider/Orders.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<String> monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  @override
  Widget build(BuildContext context) {
    getOrders();
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
        centerTitle: true,
        title: Text(
          "History",
          style: TextStyle(
            fontSize: 35,
            color: Color(0xff4c505b),
          ),
        ),
      ),
      body: HistoryBody(monthNames: monthNames),
    );
  }


}

class HistoryBody extends StatelessWidget {
  const HistoryBody({
    super.key,
    required this.monthNames,
  });

  final List<String> monthNames;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: GetBuilder<UserController>(
        builder: (controllerU) {
          return GetBuilder<ProvidersController>(
            builder: (controller) {
              return ListView.builder(
                //reverse: true,
                itemCount: orders.length,
                itemBuilder: (context,index){
                  DateTime dateTime=orders[index]['date_time'].toDate();
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.lightBlue[50],
                        child: Text(
                          (index+1).toString(),
                        ),
                      ),
                      title: Text(orders[index]['service']),
                      subtitle: Text('${dateTime.day} ${monthNames[dateTime.month-1]}, ${dateTime.year};  ${dateTime.hour}:${dateTime.minute}'),
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: getStatusColor(orders[index]['status']),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                        child: Text(
                          orders[index]['status'],
                        ),
                      )
                    ),
                  );
                },
              );
            }
          );
        }
      ),
    );
  }
  getStatusColor(String status) {
    if(status=='Done'){
      return Colors.greenAccent[100];
    }else if(status=='Running'){
      return Colors.yellow[200];
    }else if(status=='Cancelled'){
      return Colors.red[200];
    }
  }
}
