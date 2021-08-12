
import 'package:amit_final_project/tabs/cart.dart';
import 'package:amit_final_project/tabs/category.dart';
import 'package:amit_final_project/tabs/home.dart';
import 'package:amit_final_project/tabs/more.dart';
import 'package:flutter/material.dart';
class TabsPage extends StatefulWidget {
  const TabsPage({Key key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _index=0;
  List <BottomNavigationBarItem> _items =[
    BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.category),label: 'Category'),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'My Cart'),
    BottomNavigationBarItem(icon: Icon(Icons.menu),label: 'Menu'),
  ];


  List <Widget> pages ;


  @override
  Widget build(BuildContext context) {
    pages=[
      Home(),
      Category(),
      Cart(),
      More(),
    ];


    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: pages,
      ),


      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _items,
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
      ),
    );
  }
}
