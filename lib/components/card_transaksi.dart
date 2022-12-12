import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/constants/color.dart';

class CardTransaksi extends StatelessWidget {
  final String desc, image, inv, date, totalbarang, totalbelanja;
  const CardTransaksi(
      {Key? key,
      required this.desc,
      required this.image,
      required this.date,
      required this.inv,
      required this.totalbarang,
      required this.totalbelanja})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Card(
          elevation: 2,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'INV : ' + inv,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 2.0, color: greyColor),
                  )),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'DATE : ' + date,
                        style: TextStyle(color: blackColor, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            margin:
                                EdgeInsets.only(right: 10, top: 10, bottom: 10),
                            width: 60,
                            height: 60,
                            child: Image.network(image)),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  desc,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: blackColor),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Total Barang : ' + totalbarang + ' barang',
                                  style: TextStyle(
                                      fontSize: 14, color: blackColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Total Belanja',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: blackColor),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        totalbelanja,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: blackColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
