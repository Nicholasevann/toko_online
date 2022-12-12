import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/components/header_home.dart';
import 'package:toko_online/constants/color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toko_online/routes/bottom_navigation.dart';
import 'package:get/get.dart';

class DetailHome extends StatefulWidget {
  String desc,
      image,
      harga,
      stock,
      kategori,
      berat,
      preorder,
      berbahaya,
      deskripsi,
      min_pemesanan;
  DetailHome(
      {Key? key,
      required this.desc,
      required this.image,
      required this.harga,
      required this.stock,
      required this.kategori,
      required this.berat,
      required this.preorder,
      required this.berbahaya,
      required this.deskripsi,
      required this.min_pemesanan})
      : super(key: key);

  @override
  State<DetailHome> createState() => _DetailHomeState(
      this.desc,
      this.image,
      this.harga,
      this.stock,
      this.kategori,
      this.berat,
      this.preorder,
      this.berbahaya,
      this.deskripsi,
      this.min_pemesanan);
}

class _DetailHomeState extends State<DetailHome> {
  String dataId = '';
  var response = '';
  @override
  String desc,
      image,
      harga,
      stock,
      kategori,
      berat,
      berbahaya,
      preorder,
      deskripsi,
      pemesanan;
  _DetailHomeState(
      this.desc,
      this.image,
      this.harga,
      this.stock,
      this.kategori,
      this.berat,
      this.preorder,
      this.berbahaya,
      this.deskripsi,
      this.pemesanan);
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      dataId = (prefs.getString('dataId') ?? '');
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCounter();
  }

  Widget build(BuildContext context) {
    if (berbahaya == '0') {
      setState(() {
        berbahaya = 'Tidak Berbahaya';
      });
    } else if (berbahaya == '1') {
      setState(() {
        berbahaya = 'Berbahaya';
      });
    }
    if (preorder == '0') {
      setState(() {
        preorder = 'Tidak Preorder';
      });
    } else if (preorder == '1') {
      setState(() {
        preorder = 'Preorder';
      });
    }

    Future connectToAPIPost() async {
      // Uri url = Uri.parse("http://10.0.2.2/backend-tokoonline/postkeranjang/");
      Uri url = Uri.parse("http://localhost/backend-tokoonline/postkeranjang/");

      var apiResult = await http.post(url, body: {
        "nama_barang": desc,
        "total_barang": '1',
        "gambar": image,
        "total_harga": harga,
        "id_user": dataId
      });
      return json.decode(apiResult.body);
    }

    print(dataId);
    return Scaffold(
      body: Container(
        color: whiteColor,
        child: ListView(
          children: [
            HeaderHome(),
            Container(
              height: 400,
              padding: EdgeInsets.all(30),
              child: Image.network(image),
            ),
            // CarouselSlider(
            //   options: CarouselOptions(
            //     viewportFraction: 1,
            //     height: 400,
            //     aspectRatio: 16 / 9,
            //     initialPage: 0,
            //     enableInfiniteScroll: true,
            //     reverse: false,
            //     autoPlay: true,
            //     autoPlayInterval: Duration(seconds: 3),
            //     autoPlayAnimationDuration: Duration(seconds: 1),
            //     autoPlayCurve: Curves.fastOutSlowIn,
            //     scrollDirection: Axis.horizontal,
            //   ),
            //   items: [1, 2, 3].map((i) {
            //     return Builder(
            //       builder: (BuildContext context) {
            //         return Container(
            //           height: 200,
            //           padding: EdgeInsets.all(15),
            //           width: MediaQuery.of(context).size.width,
            //           child: Image(
            //             width: MediaQuery.of(context).size.width,
            //             image: AssetImage(
            //                 'assets/images/' + i.toString() + '.png'),
            //             fit: BoxFit.contain,
            //           ),
            //         );
            //       },
            //     );
            //   }).toList(),
            // ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 2.0, color: greyColor),
              )),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Rp. ' + harga,
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          desc,
                          style: TextStyle(color: blackColor, fontSize: 16),
                        )),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Sisa Stok ' + stock,
                        style: TextStyle(color: blackColor, fontSize: 14),
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Detail Produk',
                          style: TextStyle(
                              color: blackColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 2.0, color: greyColor),
                    )),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Kategori',
                              style: TextStyle(color: blackColor, fontSize: 14),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              kategori,
                              style: TextStyle(color: blackColor, fontSize: 14),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 2.0, color: greyColor),
                    )),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Pre-Order',
                              style: TextStyle(color: blackColor, fontSize: 14),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              preorder,
                              style: TextStyle(color: blackColor, fontSize: 14),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 2.0, color: greyColor),
                    )),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Berbahaya',
                              style: TextStyle(color: blackColor, fontSize: 14),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              berbahaya,
                              style: TextStyle(color: blackColor, fontSize: 14),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 2.0, color: greyColor),
                    )),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Min Pemesanan',
                              style: TextStyle(color: blackColor, fontSize: 14),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              pemesanan + ' barang',
                              style: TextStyle(color: blackColor, fontSize: 14),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border(
                      bottom: BorderSide(width: 2.0, color: greyColor),
                    )),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Berat',
                              style: TextStyle(color: blackColor, fontSize: 14),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(
                              berat + ' kg',
                              style: TextStyle(color: blackColor, fontSize: 14),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        deskripsi,
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          connectToAPIPost().then((value) {
                            setState(() {
                              response = value['status']['code'].toString();
                            });
                            if (response == '200') {
                              Get.to(BottomNavigation());
                            }
                          });
                        },
                        child: Text('Checkout'),
                        style: ElevatedButton.styleFrom(primary: blackColor),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
