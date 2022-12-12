import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/constants/color.dart';
import 'package:toko_online/screens/login_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  var response = '';
  String nama = '', email = '', password = '', alamat = '', no_telepon = '';
  Future connectToAPIPost() async {
    Uri url = Uri.parse("http://10.0.2.2/backend-tokoonline/postdata/");
    var apiResult = await http.post(url, body: {
      "nama": nama,
      "email": email,
      "password": password,
      "no_telepon": no_telepon,
      "alamat": alamat
    });
    return json.decode(apiResult.body);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Align(
          alignment: Alignment.center,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Text(
                      'Silahkan mengisi data untuk sign up!',
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          nama = val;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nama',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          no_telepon = val;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'No Telpon',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          alamat = val;
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Alamat',
                      ),
                    ),
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(blackColor)),
                        child: Text('Sign Up'),
                        onPressed: () {
                          connectToAPIPost().then((value) {
                            setState(() {
                              response = value['status']['code'].toString();
                            });
                            if (response == '200') {
                              Get.to(Login());
                            }
                          });
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return Login();
                          // }));
                        },
                      )),
                  Row(
                    children: [
                      const Text('Have an account?'),
                      TextButton(
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: blackColor),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Login();
                          }));
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
