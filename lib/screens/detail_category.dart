import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/components/card_produk.dart';
import 'package:toko_online/constants/color.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toko_online/screens/detailhome_screen.dart';

class DetailCategory extends StatefulWidget {
  String id_category, nama_category;
  DetailCategory(
      {Key? key, required this.id_category, required this.nama_category})
      : super(key: key);

  @override
  State<DetailCategory> createState() =>
      _DetailCategoryState(this.id_category, this.nama_category);
}

class _DetailCategoryState extends State<DetailCategory> {
  String id_category, nama_category;
  _DetailCategoryState(this.id_category, this.nama_category);
  dynamic arrayData = [];
  Future<dynamic>? _future;
  Future connectToAPIPost() async {
    // Uri url =
    //     Uri.parse("http://10.0.2.2/backend-tokoonline/postprodukkategori/");
    Uri url =
        Uri.parse("http://localhost/backend-tokoonline/postprodukkategori/");
    var apiResult = await http.post(url, body: {
      "id_kategori": id_category,
    });
    var arrayjson = json.decode(apiResult.body);
    arrayData.addAll(arrayjson['status']['data']);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = connectToAPIPost();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori ' + nama_category),
        backgroundColor: blackColor,
      ),
      body: Container(
          padding: EdgeInsets.all(16),
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.data == []) {
                return Text('Loading');
              } else {
                return Wrap(
                  children: List.generate(
                    arrayData.length,
                    (index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailHome(
                                        desc: arrayData[index]['nama_produk'],
                                        image: arrayData[index]['gambar'],
                                        harga: arrayData[index]['harga'],
                                        stock: arrayData[index]['stok'],
                                        kategori: arrayData[index]
                                            ['nama_kategori'],
                                        berat: arrayData[index]['berat'],
                                        preorder: arrayData[index]['preorder'],
                                        berbahaya: arrayData[index]
                                            ['berbahaya'],
                                        deskripsi: arrayData[index]
                                            ['deskripsi'],
                                        min_pemesanan: arrayData[index]
                                            ['min_pemesanan'])));
                          },
                          child: CardProduk(
                            desc: arrayData[index]['nama_produk'],
                            image: arrayData[index]['gambar'],
                            harga: arrayData[index]['harga'],
                            stok: arrayData[index]['stok'],
                            kategori: arrayData[index]['nama_kategori'],
                          ));
                    },
                  ),
                );
              }
            },
          )),
    );
  }
}
