import 'package:flutter/material.dart';
import 'package:full_e_commerce_app/pages/home/main_food_page.dart';

import '../../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> pages = [
    MainFoodPage(),
    Container(child: Center(child: const Text('First Page')),),
    Container(child: Center(child: const Text('Second Page')),),
    Container(child: Center(child: const Text('Third Page')),),

  ];
  void onTapNav(int index){
    setState((){
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: true,
        onTap: onTapNav,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.archive),label: 'history'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'me'),
        ],
      ),
    );
  }
}
