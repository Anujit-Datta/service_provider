import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Controllers/providersController.dart';
import 'package:service_provider/Pages/services.dart';
import 'package:service_provider/serviceModel.dart';
import 'package:service_provider/userModel.dart';
import 'package:get/get.dart';
import 'launcher.dart';

String currUserImage='';
String currUserName='';
List servicesImage = [
  'assets/electrician.png',
  'assets/plumber.png',
  'assets/cleaner.png',
  'assets/painter.png',
  'assets/ISP.png'
];

class userHomePage extends StatefulWidget {
  const userHomePage({super.key});
  @override
  State<userHomePage> createState() => _userHomePageState();
}

class _userHomePageState extends State<userHomePage> {
  bool proceed = false;

  @override
  Widget build(BuildContext context) {
    ProvidersController controller=Get.put(ProvidersController());
    final _auth= FirebaseAuth.instance;
    getCurrUserModel().then((value) {
      currUserImage=currUserModel.image;
      currUserName=currUserModel.name;
    });

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.menu,
              color: Color(0xff4c505b),
              size: 40,
            ),
            onPressed: (){
              Scaffold.of(context).openDrawer();

            },
          );
        }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 1,
            ),
            Text(
              'Services',
              style: TextStyle(
                fontSize: 30,
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
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: MediaQuery.of(context).orientation==Orientation.portrait
                    ? SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.41,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                    )
                    : SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.25,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                    ),
                    itemCount: controller.services.length,
                    itemBuilder: (BuildContext context, int index) {
                      return serviceContainer(controller.services[index], index,controller);
                    }),
              ),
            ]),
      ),

      drawer: NavigationDrawer(
        backgroundColor: Colors.grey.shade200,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightBlueAccent.shade200,
            ),
            padding:
                EdgeInsets.only(top:  MediaQuery.of(context).padding.top),
            height: MediaQuery.of(context).orientation==Orientation.portrait?MediaQuery.of(context).size.height * 0.30:MediaQuery.of(context).size.width * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(currUserImage==''?'https://firebasestorage.googleapis.com/v0/b/service-provider-2798f.appspot.com/o/user-male-circle.png?alt=media&token=f95cd854-6136-4118-94cd-4abfb3f48656':currUserImage),
                ),
                Text(
                    currUserName,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                top: MediaQuery.of(context).size.height * 0.02,
                bottom: MediaQuery.of(context).size.height * 0.005),
            minLeadingWidth: 5,
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Get.to(()=>userHomePage());
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                top: MediaQuery.of(context).size.height * 0.005,
                bottom: MediaQuery.of(context).size.height * 0.005),
            minLeadingWidth: 5,
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                top: MediaQuery.of(context).size.height * 0.005,
                bottom: MediaQuery.of(context).size.height * 0.005),
            minLeadingWidth: 5,
            leading: Icon(Icons.history),
            title: Text(
              'History',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                top: MediaQuery.of(context).size.height * 0.005,
                bottom: MediaQuery.of(context).size.height * 0.005),
            minLeadingWidth: 5,
            leading: Icon(Icons.info_outline),
            title: Text(
              'About Us',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                top: MediaQuery.of(context).size.height * 0.005,
                bottom: MediaQuery.of(context).size.height * 0.005),
            minLeadingWidth: 5,
            leading: Icon(Icons.contact_mail_outlined),
            title: Text(
              'Contact Us',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.08,
                top: MediaQuery.of(context).size.height * 0.005,
                bottom: MediaQuery.of(context).size.height * 0.005),
            minLeadingWidth: 5,
            leading: Icon(Icons.logout_outlined),
            title: Text(
              'Sign out',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              currUserModel=userModel(phone: '', email: '', address: '');
              controller.currService=-1;
              currUserDoc='';
              currUserName='';
              currUserImage='';
              _auth.signOut();
              Get.to(()=>launcherPage());
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
      floatingActionButton: proceedButton(controller),
      bottomNavigationBar: BottomNavigationBar(
          items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist_rtl_sharp),
          label: 'History',
        )
      ]),
    );
  }


  Container proceedButton(ProvidersController controller) {
    if (proceed)
      return Container(
        height: 70,
        width: 70,
        child: GetBuilder<ProvidersController>(builder: (_){
          return FittedBox(
            child: FloatingActionButton(
              splashColor: Colors.blueGrey,
              onPressed: () {
                Get.to(()=>Services());
              },
              child: Icon(Icons.arrow_forward_ios),
            ),
          );
        },),
      );
    else
      return Container();
  }

  serviceContainer(String name, int index,ProvidersController controller) {
    return GetBuilder<ProvidersController>(builder: (_){
      return GestureDetector(
        onTap: () {
          setState(() {
            if (controller.currService == index) {
              controller.currService = -1;
              proceed = false;
            } else {
              controller.currService=index;
              proceed = true;
            }
          });
        },
        child: Container(
          padding: EdgeInsets.all(1.0),
          decoration: BoxDecoration(
            color: controller.currService == index
                ? Colors.blueGrey
                : Colors.lightBlueAccent.shade100,
            border: Border.all(
              color: controller.currService == index
                  ? Colors.blueGrey
                  : Colors.blueGrey.withOpacity(0),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(servicesImage[index]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 25),
                )
              ]),
        ),
      );
    },);
  }
}
