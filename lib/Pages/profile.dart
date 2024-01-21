
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_provider/Controllers/UserController.dart';
import 'package:service_provider/Controllers/providersController.dart';
import 'package:service_provider/Pages/launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    UserController controllerU=Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Color(0xff4c505b),
          onPressed: (){
            controllerU.bottomNevBarItemSetter(1);
            Get.back();
          },
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 35,
            color: Color(0xff4c505b),
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.edit_note_rounded)
          )
        ],
      ),
      body: profileBody(controllerU: controllerU,controller: Get.find<ProvidersController>(),),
    );
  }
}

class profileBody extends StatefulWidget {
  const profileBody({
    super.key,
    required this.controllerU,
    required this.controller,
  });

  final UserController controllerU;
  final ProvidersController controller;

  @override
  State<profileBody> createState() => _profileBodyState();
}

class _profileBodyState extends State<profileBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: GetBuilder<UserController>(builder: (_){
              return ListView(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.35,
                    child: CircleAvatar(
                      backgroundColor: Colors.lightBlueAccent,
                      radius: MediaQuery.of(context).size.width * 0.35,
                      foregroundImage: NetworkImage(
                        loginType==true?widget.controllerU.currUserModel.image:widget.controller.currProviderModel.image,
                      ),
                      //backgroundImage: ,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      loginType==true?widget.controllerU.currUserModel.name:widget.controller.currProviderModel.name,
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
                                  Icons.location_on,
                                  color: Colors.grey,
                                )),
                            horizontalTitleGap: 5,
                            minLeadingWidth: 20,
                            title: Text(
                              loginType==true?widget.controllerU.currUserModel.address:widget.controller.currProviderModel.address,
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
                                  Icons.alternate_email,
                                  color: Colors.grey,
                                )),
                            horizontalTitleGap: 5,
                            minLeadingWidth: 20,
                            title: Text(
                              loginType==true?widget.controllerU.currUserModel.email:widget.controller.currProviderModel.email,
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
                                  Icons.call,
                                  color: Colors.grey,
                                )),
                            horizontalTitleGap: 5,
                            minLeadingWidth: 20,
                            title: Text(
                              loginType==true?widget.controllerU.currUserModel.phone:widget.controller.currProviderModel.phone,
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
      ],
    );
  }
}
