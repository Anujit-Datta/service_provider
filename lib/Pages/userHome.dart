import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/routes.dart';
import 'package:service_provider/serviceModel.dart';
int currService=-1;

class userHomePage extends StatefulWidget {
  const userHomePage({super.key});
  @override
  State<userHomePage> createState() => _userHomePageState();
}

class _userHomePageState extends State<userHomePage> {
  bool proceed = false;

  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    final _auth= FirebaseAuth.instance;
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
            onPressed: () => Scaffold.of(context).openDrawer(),
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
        padding: EdgeInsets.all(30.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 30.0,
                      mainAxisSpacing: 30.0,
                    ),
                    itemCount: services.length,
                    itemBuilder: (BuildContext context, int index) {
                      return serviceContainer(services[index], index);
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
              color: Colors.lightBlueAccent.shade400,
            ),
            padding:
                EdgeInsets.only(top:  MediaQuery.of(context).padding.top),
            height: MediaQuery.of(context).size.height * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage('https://img.icons8.com/ios-filled/100/user-male-circle.png'),
                ),
                Text(
                    'Name',
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
              Navigator.pushReplacementNamed(context, userHomePageRoute);
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
              Navigator.pushReplacementNamed(context, userHomePageRoute);
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
              Navigator.pushReplacementNamed(context, userHomePageRoute);
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
              Navigator.pushReplacementNamed(context, userHomePageRoute);
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
              Navigator.pushReplacementNamed(context, userHomePageRoute);
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
              _auth.signOut();
              Navigator.pushReplacementNamed(context, launcherRoute);
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
      floatingActionButton: proceedButton(),
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

  Container proceedButton() {
    if (proceed)
      return Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            splashColor: Colors.blueGrey,
            onPressed: () {
              serviceName=services[currService];
              Navigator.pushNamed(context, servicesRoute);
            },
            child: Icon(Icons.arrow_forward_ios),
          ),
        ),
      );
    else
      return Container();
  }

  serviceContainer(String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (currService == index) {
            currService = -1;
            proceed = false;
          } else {
            currService=index;
            proceed = true;
          }
        });
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: currService == index
              ? Colors.blueGrey
              : Colors.lightBlueAccent.shade100,
          border: Border.all(
            color: currService == index
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
                height: 20,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 20),
              )
            ]),
      ),
    );
  }
}
