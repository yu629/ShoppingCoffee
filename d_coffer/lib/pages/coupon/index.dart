import 'package:color_dart/color_dart.dart';
import 'package:d_coffer/components/customAppbar.dart';
import 'package:d_coffer/pages/coupon/coupon_row.dart';
import 'package:d_coffer/pages/toolbar/menu/detail/a_buttom.dart';
import 'package:d_coffer/utils/global.dart';
import 'package:flutter/material.dart';


class Coupon extends StatefulWidget {
  Coupon({Key key}) : super(key: key);

  _CouponState createState() => _CouponState();
}

class _CouponState extends State<Coupon> {
  double bottom = Global.screenPadding().bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: '可使用优惠券',
        context: context,
      ),
      body: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: ListView(
              padding: EdgeInsets.only(bottom: 80 + bottom),
              children: <Widget>[
                CouponRow(),
                    CouponRow(),
                    CouponRow(),
                    CouponRow(),
                    CouponRow(),
                    CouponRow(),
                    CouponRow(),
                    CouponRow(),
                    CouponRow(),
              ],
            ),
          ),
          
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              color: hex('#fff'),
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: bottom, top: bottom/2),
              width: Global.screenWidth(),
              child: AButton.normal(
                width: 300,
                child: Text('保存'),
                color: hex('#fff'),
                bgColor: rgba(144, 192, 239, 1),
                onPressed: () => {}
              ),
            ),
          )
        ],),
    );
  }
}


