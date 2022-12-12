import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/components/header_home.dart';
import 'package:toko_online/components/item_category.dart';
import 'package:toko_online/constants/color.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:toko_online/screens/detail_category.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  dynamic arrayData = [];
  Future<dynamic>? _future;
  Future connectToAPI() async {
    // Uri url = Uri.parse("http://10.0.2.2/backend-tokoonline/getkategori/");
    Uri url = Uri.parse("http://localhost/backend-tokoonline/getkategori/");

    var hasilResponse = await http.get(url);
    var dataJSON = json.decode(hasilResponse.body);
    arrayData.addAll(dataJSON);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = connectToAPI();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: 30, left: 0, right: 0, child: HeaderHome()),
          Container(
            margin: EdgeInsets.only(top: 120),
            child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.data == []) {
                  return Text('Loading Screen');
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: arrayData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: (() {
                              Get.to(DetailCategory(
                                id_category: arrayData[index]['id_kategori'],
                                nama_category: arrayData[index]
                                    ['nama_kategori'],
                              ));
                            }),
                            child: ItemCategory(
                              desc: arrayData[index]['nama_kategori'],
                              image: arrayData[index]['gambar_kategori'],
                            ));
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
