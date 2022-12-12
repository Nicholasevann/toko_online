import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:toko_online/constants/color.dart';

class ItemCategory extends StatelessWidget {
  final String desc, image;
  const ItemCategory({
    Key? key,
    required this.desc,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
          margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 2.0, color: greyColor),
          )),
          child: Row(
            children: [
              Container(width: 100, height: 100, child: Image.network(image)),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  desc,
                  style: TextStyle(
                      color: blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
