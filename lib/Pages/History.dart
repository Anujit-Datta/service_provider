import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/Controllers/OrderController.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<String> monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  @override
  void initState() {
    super.initState();
    Get.find<OrderController>().getHistory();
  }
  @override
  Widget build(BuildContext context) {
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
      body: GetBuilder<OrderController>(
        builder: (oController) {
          return oController.history.length>0?HistoryBody(monthNames: monthNames):Center(child: CircularProgressIndicator());
        }
      ),
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
    final OrderController controllerO=Get.find<OrderController>();
    controllerO.getHistory();
    return RefreshIndicator(
      onRefresh: ()async{
        controllerO.getHistory();
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: GetBuilder<OrderController>(
          builder: (_) {
            return ListView.builder(
              //reverse: true,
              itemCount: controllerO.history.length,
              itemBuilder: (context,index){
                DateTime dateTime=controllerO.history[index].orderDateTime;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.lightBlue[50],
                      child: Text(
                        (index+1).toString(),
                      ),
                    ),
                    title: Text(controllerO.history[index].orderType),
                    subtitle: Text('${dateTime.day} ${monthNames[dateTime.month-1]}, ${dateTime.year};  ${dateTime.hour}:${dateTime.minute}'),
                    trailing: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: getStatusColor(controllerO.history[index].orderStatus),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                      child: Text(
                        controllerO.history[index].orderStatus,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        ),
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
    }else{
      return Colors.grey[300];
    }
  }
}
