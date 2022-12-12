import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/screens/home_screen.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(children: [
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home Page', style: TextStyle(fontSize: 18)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }));
            },
          ),
          Divider(height: 3.0),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings', style: TextStyle(fontSize: 18)),
            onTap: () {
              // Here you can give your route to navigate
            },
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text('Close Drawer', style: TextStyle(fontSize: 18)),
            onTap: () {
              // to close drawer programatically..
              Navigator.of(context).pop();
            },
          ),
        ]),
      ),
    );
  }
}
