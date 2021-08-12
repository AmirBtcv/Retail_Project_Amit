import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class More extends StatefulWidget {
  const More({Key  key}) : super(key: key);

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('More',style: TextStyle(color: Colors.lightBlue),),
        centerTitle: true,


      ),
      body: SafeArea(
        child: Column(
          children: [


            // Padding(padding: const EdgeInsets.fromLTRB(30, 20, 30, 30)),
            Container(
                height: 80,
                // alignment:Alignment(3,0) ,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,

                    children: [Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                        children:[ Padding(
                          padding: const EdgeInsets.only(left: 30,bottom: 10),
                          child: Text('OTHERS'),
                        )])])),








            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.approval,color: Colors.lightBlue,),
              title: Text('Rate App'),
              trailing: Icon(Icons.arrow_forward_ios_outlined),



            ),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.ios_share,color: Colors.lightBlue,),
              title: Text('Share App'),
              // subtitle: Column(children: [Expanded (child:IntrinsicHeight())]),
              trailing: Icon(Icons.arrow_forward_ios_outlined),

              // isThreeLine: true,

            ),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.contact_phone_outlined,color: Colors.lightBlue,),
              title: Text('Contact US'),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
                // isThreeLine: true
            ),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.account_circle_outlined,color: Colors.lightBlue,),
              title: Text('Log In'),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
                // isThreeLine: true
            ),
            ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.settings,color: Colors.lightBlue,),
              title: Text('Settings'),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
                // isThreeLine: true
            ),
          ],
        ),
        

      ),

      );




  }
}
