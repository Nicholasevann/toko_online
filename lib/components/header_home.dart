import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/constants/color.dart';
import 'package:toko_online/screens/checkout.screen.dart';
import 'package:toko_online/screens/detailsearch_screen.dart';
import 'package:toko_online/screens/profile_screen.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      child: Container(
        color: whiteColor,
        padding: EdgeInsets.all(16),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailSearch();
                }));
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: blackColor),
                    borderRadius: BorderRadius.circular(5)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Search Product ...",
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Checkout();
              }));
            },
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/icons/chart.png'))),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Profile();
              }));
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage('assets/icons/people.png'))),
            ),
          ),
        ]),
      ),
    );
  }
}
