import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/Pages/profile.dart';
import 'package:service_provider/Pages/userHome.dart';
import '../Controllers/UserController.dart';
import '../Controllers/providersController.dart';

List<Widget> pages=[
  profileBody(controllerU: Get.find<UserController>(),controller: Get.find<ProvidersController>(),),
  ProviderHomeBody(controller: Get.find<ProvidersController>()),
  profileBody(controllerU: Get.find<UserController>(),controller: Get.find<ProvidersController>(),),
];

class ProviderHomePage extends StatefulWidget {
  const ProviderHomePage({super.key});

  @override
  State<ProviderHomePage> createState() => _ProviderHomePageState();
}

class _ProviderHomePageState extends State<ProviderHomePage> {
  final _auth = FirebaseAuth.instance;
  List pagesName = ['Profile', 'Sessions', 'History'];
  ProvidersController controller = Get.find<ProvidersController>();

  @override
  void initState() {
    controller.getCurrProviderModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(
              Icons.menu,
              color: Color(0xff4c505b),
              size: 40,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        title: Text(
          pagesName[controller.bottomNevBarItemSelected],
          style: TextStyle(
            fontSize: 30,
            color: Color(0xff4c505b),
          ),
        ),
      ),
      body: pages[controller.bottomNevBarItemSelected],
      drawer: SideNavigationDrawer(controllerU: Get.find<UserController>(), controller: controller, auth: _auth),
      bottomNavigationBar: GetBuilder<ProvidersController>(builder: (_) {
        return BottomNavigationBar(
            onTap: (index) {
              controller.bottomNevBarItemSetter(index);
              pages[index];
              setState(() {});
            },
            currentIndex: controller.bottomNevBarItemSelected,
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
              ),
            ]);
      }),
    );
  }
}

class ProviderHomeBody extends StatelessWidget {
  const ProviderHomeBody({
    super.key, required ProvidersController controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.03,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.shade100,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListTile(
                      isThreeLine: true,
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.work_history_outlined),
                        ],
                      ),
                      title: Text('sdvucsd'),
                      subtitle: Text('sdgv'),
                      trailing: SizedBox(
                        width: MediaQuery.sizeOf(context).width*0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: (){},
                              child: Text('Cancel',
                              style: TextStyle(
                                color: Colors.red.shade300,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                              ),
                            ),TextButton(
                              onPressed: (){},
                              child: Text('Accept',
                                style: TextStyle(
                                  color: Colors.green.shade300,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
