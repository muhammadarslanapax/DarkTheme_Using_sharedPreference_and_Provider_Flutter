import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home/home_page.dart';
import '../setting/setting_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedindex = 0;
  var _screens =[Home(),Setting()];
  void ontab(index){
    selectedindex = index;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),

        ],
        currentIndex: selectedindex,
        onTap: ontab,


      ),
      body: _screens.elementAt(selectedindex),

    );
  }
}
