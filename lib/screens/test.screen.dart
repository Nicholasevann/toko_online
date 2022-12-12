import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<dynamic> arrayData = [];
  var response = '';
  @override
  Future connectToAPI() async {
    Uri url = Uri.parse("http://10.0.2.2/backend-tokoonline/getuser/");

    var hasilResponse = await http.get(url);
    final dataJSON = json.decode(hasilResponse.body);
    arrayData.addAll(dataJSON);
  }

  Future connectToAPIPost() async {
    Uri url = Uri.parse("http://10.0.2.2/backend-tokoonline/postdata/");
    var apiResult = await http.post(url, body: {
      "nama": "Bokisss",
      "email": "Bokis@gmail.com",
      "password": "Bokis123",
      "no_telepon": "0812212",
    });
    return json.decode(apiResult.body);
  }

  Widget build(BuildContext context) {
    print(response);
    if (response == '200') {
      print('berhasil');
    } else if (response != '') {
      print('gagal');
    }
    return Scaffold(
      body: Column(
        children: [
          // Container(
          //   child: Card(
          //     child: FutureBuilder(
          //         future: connectToAPI(),
          //         builder: (context, snapshot) {
          //           if (snapshot.data == []) {
          //             return Text('Loading');
          //           } else {
          //             return ListView.builder(
          //                 shrinkWrap: true,
          //                 itemCount: arrayData.length,
          //                 itemBuilder: (BuildContext context, int index) {
          //                   return Text(arrayData[index]['nama']);
          //                 });
          //           }
          //         }),
          //   ),
          // ),
          ElevatedButton(
              onPressed: () {
                connectToAPIPost().then((value) {
                  setState(() {
                    response = value['status']['code'].toString();
                  });
                });
              },
              child: Text('post')),
              
        ],
      ),
    );
  }
}
