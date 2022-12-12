import 'package:flutter/material.dart';
import 'package:toko_online/constants/color.dart';
import 'package:toko_online/routes/drawer_navigation.dart';
import 'package:toko_online/screens/category_screen.dart';
import 'package:toko_online/screens/home_screen.dart';
import 'package:toko_online/screens/transaksi_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Category(),
    Transaksi(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Transaksi',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: blackColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
