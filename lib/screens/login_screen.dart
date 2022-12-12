import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/constants/color.dart';
import 'package:toko_online/routes/bottom_navigation.dart';
import 'package:toko_online/screens/signup_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '', password = '', response = '', dataId = '';
  dynamic data;
  bool obscureText = true;
  Future connectToAPILogin() async {
    // Uri url = Uri.parse("http://10.0.2.2/backend-tokoonline/login/");
    Uri url = Uri.parse("http://localhost/backend-tokoonline/login/");
    var apiResult = await http.post(url, body: {
      "email": email,
      "password": password,
    });
    return json.decode(apiResult.body);
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(32),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login' + dataId,
                  style: TextStyle(
                      color: blackColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                    'Masukkan email dan password!',
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40, bottom: 16),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    onChanged: ((value) {
                      setState(() {
                        email = value;
                      });
                    }),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        obscureText: obscureText,
                        onChanged: ((value) {
                          setState(() {
                            password = value;
                          });
                        }),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: new Text(
                            obscureText ? "Show" : "Hide",
                            style: TextStyle(color: blackColor),
                          )),
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: blackColor, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(blackColor)),
                      child: const Text('Login'),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        connectToAPILogin().then((value) {
                          setState(() {
                            response = value['status']['code'].toString();
                          });
                          setState(() {
                            data = value['status']['data'];
                          });
                          prefs.setString('dataId', data['id_user']);
                          prefs.setString('dataNama', data['nama']);
                          prefs.setString('dataEmail', data['email']);
                          prefs.setString('dataNoTelp', data['no_telp']);
                          prefs.setString('dataAlamat', data['alamat']);
                          if (response == '200') {
                            Get.to(BottomNavigation());
                          }
                        });
                        // print(nameController.text);
                        // print(passwordController.text);
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return BottomNavigation();
                        // }));
                      },
                    )),
                Row(
                  children: [
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: blackColor),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SignUp();
                        }));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
