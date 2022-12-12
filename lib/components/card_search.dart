import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/constants/color.dart';

class CardSearch extends StatelessWidget {
  final String desc, image, harga;
  const CardSearch({
    Key? key,
    required this.desc,
    required this.image,
    required this.harga,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: greyColor))),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            width: 100,
            height: 100,
            child: Image.network(image),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        desc,
                        style: TextStyle(fontSize: 16),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Rp. ' + harga,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
