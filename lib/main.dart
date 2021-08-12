import 'package:amit_final_project/login/Login.dart';
import 'package:amit_final_project/login/Registration.dart';
import 'package:amit_final_project/tabs/home.dart';
import 'package:amit_final_project/tabs/tabspage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp( debugShowCheckedModeBanner:false,
          // home:Registration()
      home: Login()
      // home: TabsPage()
      ,));

}

