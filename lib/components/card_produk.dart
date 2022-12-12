import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/constants/color.dart';

class CardProduk extends StatelessWidget {
  final String desc, image, harga, stok, kategori;
  const CardProduk(
      {Key? key,
      required this.desc,
      required this.image,
      required this.harga,
      required this.stok,
      required this.kategori})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 270,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.all(8), child: Image.network(image)),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(desc,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, bottom: 8),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Rp. ' + harga,
                          style: TextStyle(
                              color: blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 4),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Sisa Stok :' + stok,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 4),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Kategori : ' + kategori,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
