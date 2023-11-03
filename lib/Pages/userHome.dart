import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/routes.dart';
import '';

class userHomePage extends StatefulWidget {
  const userHomePage({super.key});

  @override
  State<userHomePage> createState() => _userHomePageState();
}

class _userHomePageState extends State<userHomePage> {
  static final electrician = 'Electrician';
  static final plumber = 'Plumber';
  static final cleaner = 'Cleaner';
  static final painter = 'Painter';
  static final isp = 'ISP';
  List services = [electrician, plumber, cleaner, painter, isp];
  List servicesImage = [
    'assets/electrician.png',
    'assets/plumber.png',
    'assets/cleaner.png',
    'assets/painter.png',
    'assets/ISP.png'
  ];
  int selectedService = -1;
  bool proceed = false;

  @override
  Widget build(BuildContext context) {
    final _db = FirebaseFirestore.instance;
    return Scaffold(
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
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: services.length,
                    itemBuilder: (BuildContext context, int index) {
                      return serviceContainer(services[index], index);
                    }),
              ),
            ]),
      ),
      drawer: NavigationDrawer(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightBlueAccent,
            ),
            padding:
                EdgeInsets.only(top: 24 + MediaQuery.of(context).padding.top),
            height: MediaQuery.of(context).size.height * 0.30,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('assets/profileavater.png'),
                ),
                Text('Name'),
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          ListTile(
            contentPadding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.12),
            title: Text('Apply as Provider',style: TextStyle(fontSize: 25,color: Colors.redAccent),),
            onTap: (){},
          )
        ],
      ),
      floatingActionButton: proceedButton(),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
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
            onPressed: () {},
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
          if (selectedService == index) {
            selectedService = -1;
            proceed = false;
          } else {
            selectedService = index;
            proceed = true;
          }
        });
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: selectedService == index
              ? Colors.blueGrey
              : Colors.lightBlueAccent.shade100,
          border: Border.all(
            color: selectedService == index
                ? Colors.blueGrey
                : Colors.blueGrey.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
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
