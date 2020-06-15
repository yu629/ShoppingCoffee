import 'package:color_dart/HexColor.dart';
import 'package:color_dart/RgbaColor.dart';
import 'package:d_coffer/jsonserialize/goods_list/data.dart';
import 'package:d_coffer/utils/global.dart';
import 'package:flutter/material.dart';

class GoodsListItem extends StatelessWidget {
  GoodsListItem({this.border = true, this.activeDesc, this.onPress, this.data});

  final bool border;
  final bool activeDesc;
  final Function onPress;
  final GoodsListDatum data;
  final List actives = ['满50减20', '充2赠1', '买2送1'];

  Widget row(String title,
      {double fontSize = 11, FontWeight fontWeight, Color color}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: TextStyle(
                color: color == null ? rgba(166, 166, 166, 1) : color,
                fontSize: fontSize,
                fontWeight:
                    fontWeight == null ? FontWeight.normal : fontWeight),
          ),
        )
      ],
    );
  }

  /// 商品图片
  Widget goodsImg(String imgSrc) {
    return ClipRRect(
        borderRadius: new BorderRadius.circular(4.0),
        child: Image.network(
          imgSrc,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        ));
  }

  ///活动信息
  Widget activeMsg({String text}) {
    return text == null
        ? Container()
        : Positioned(
            right: 0,
            bottom: 5,
            child: Container(
              height: 16,
              padding: EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(2.0),
                  color: rgba(255, 129, 2, 1)),
              child: Text(
                text,
                style: TextStyle(color: hex('#fff'), fontSize: 8),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Global.borderBottom(show: border),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 80,
                  height: 70,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: goodsImg(data.pic),
                      ),
                      activeMsg(text: activeDesc ? actives[0] : actives[1])
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 6),
                    child: Column(
                      children: <Widget>[
                        row(data.name,
                            color: rgba(56, 56, 56, 1),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        row(data.characteristic.isEmpty
                            ? ''
                            : data.characteristic),
                        row(""),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "¥ ${data.originalPrice}",
                                style: TextStyle(
                                    color: rgba(56, 56, 56, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    child: icontubiao(
                                        color: rgba(136, 175, 213, 1),
                                        size: 25),
                                  ),
                                  onTap: () {
                                    if (onPress != null) {
                                      onPress(context, data.id);
                                    }
                                  })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
