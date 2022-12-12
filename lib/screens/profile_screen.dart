import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/components/header_home.dart';
import 'package:toko_online/constants/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:toko_online/screens/login_screen.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        HeaderHome(),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage('assets/icons/people.png'))),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: InkWell(
                  splashColor: whiteColor,
                  child: SizedBox(
                      width: 150,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('dataId');
                            prefs.remove('dataNama');
                            prefs.remove('dataEmail');
                            prefs.remove('dataNoTelp');
                            prefs.remove('dataAlamat');
                            Get.to(Login());
                          },
                          child: Text('Logout'),
                          style: ElevatedButton.styleFrom(primary: blackColor),
                        ),
                      )),
                ),
              ),
              // Container(
              //     width: 150,
              //     height: 50,
              //     margin: EdgeInsets.only(top: 20),
              //     decoration: BoxDecoration(
              //         color: blackColor,
              //         borderRadius: BorderRadius.circular(20)),
              //     child: Align(
              //       alignment: Alignment.center,
              //       child: Text(
              //         'Logout',
              //         style: TextStyle(
              //             color: whiteColor, fontWeight: FontWeight.w600),
              //       ),
              //     )),
            ],
          ),
        ),
      ]),
    );
  }
}
