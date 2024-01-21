import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black87,),
          onPressed: (){
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 30,
            color: Color(0xff4c505b),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Image.asset('assets/contact.jpg'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 5,),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).width*0.25,
                    width: MediaQuery.sizeOf(context).width*0.25,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.amberAccent.shade100,
                            child: Icon(
                                Icons.wifi_calling_3,
                              color: Colors.amber.shade900,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Call Us",
                            style: TextStyle(
                              color: Colors.amber.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).width*0.25,
                    width: MediaQuery.sizeOf(context).width*0.25,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.amberAccent.shade100,
                            child: Icon(
                                Icons.alternate_email,
                              color: Colors.amber.shade900,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Email",
                            style: TextStyle(
                              color: Colors.amber.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ) ,

                Expanded(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).width*0.25,
                    width: MediaQuery.sizeOf(context).width*0.25,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      elevation: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.amberAccent.shade100,
                            child: Icon(
                                Icons.chat,
                              color: Colors.amber.shade900,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Whatsapp",
                            style: TextStyle(
                              color: Colors.amber.shade800,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5,),
              ],
            ),
            SizedBox(height: 15,),
            Text(
              'Support Chat',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // Remove underline
                  ),
                  maxLines: 5,
                ),
              ),
            ),
            SizedBox(height: 5,),
            MaterialButton(
              onPressed: (){},
              child: Text(
                'Send',
                style: TextStyle(
                  color: Colors.amber.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.amberAccent.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
