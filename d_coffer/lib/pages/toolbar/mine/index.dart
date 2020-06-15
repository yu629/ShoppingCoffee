import 'package:color_dart/RgbaColor.dart';
import 'package:d_coffer/components/a_row/a_row.dart';
import 'package:d_coffer/jsonserialize/user/data.dart';
import 'package:d_coffer/utils/Icon.dart';
import 'package:d_coffer/utils/global.dart';
import 'package:flutter/material.dart';

class Mine extends StatefulWidget {
  static _MineState _mineState;

  getAppBar() => _mineState.createAppBar();

  Mine() {
    _mineState = _MineState();
  }
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {
  AppBar createAppBar() {
    return null;
  }

  ARow buildUser() {
    UserData userData = Global.user.data;
    return ARow(
      height: 55,
      color: Colors.transparent,
      border: Global.borderBottom(show: false),
      padding: EdgeInsets.all(0),
      leftChild: ClipRRect(
          borderRadius: new BorderRadius.circular(27),
          child: Image.asset(
            'assets/images/mine/mine1.png',
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          )),
      centerChild: Container(
        margin: EdgeInsets.only(left: 10),
        child: Text(
          userData == null ? '立即登录' : userData.nick,
          style: TextStyle(color: rgba(255, 255, 255, 1), fontSize: 18),
        ),
      ),
      rightChild: icontupian6(size: 14, color: rgba(255, 255, 255, .6)),
      onPressed: () {
        if (userData == null) return Global.pushNamed('/login_mail');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Container(
          color: rgba(248, 248, 248, 1),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                height: 180,
                color: rgba(100, 68, 60, 1),
                padding: EdgeInsets.only(left: 20, right: 20, top: 44),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(bottom: 20),
                          child: icontupian18(
                              size: 24, color: rgba(255, 255, 255, .9))),
                      buildUser(),
                    ]),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              ARow(
                height: 50,
                padding: EdgeInsets.all(0),
                leftChild: Container(
                    width: 30,
                    alignment: Alignment.centerLeft,
                    child:
                        icontupian5(color: rgba(220, 220, 220, 1), size: 16)),
                centerChild: Text('个人资料'),
                rightChild:
                    icontupian6(color: rgba(228, 228, 228, 1), size: 14),
              ),
              ARow(
                height: 50,
                padding: EdgeInsets.all(0),
                leftChild: Container(
                  width: 30,
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: EdgeInsets.only(bottom: 5),
                      child: icontupian11(
                          color: rgba(220, 220, 220, 1), size: 20)),
                ),
                centerChild: Text('咖啡钱包'),
                rightChild:
                    icontupian6(color: rgba(228, 228, 228, 1), size: 14),
              ),
              ARow(
                height: 50,
                padding: EdgeInsets.all(0),
                leftChild: Container(
                  width: 30,
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child:
                          icontupian7(color: rgba(220, 220, 220, 1), size: 20)),
                ),
                centerChild: Text('优惠券'),
                rightChild:
                    icontupian6(color: rgba(228, 228, 228, 1), size: 14),
                onPressed: () => Global.pushNamed('/coupon'),
              ),
              ARow(
                height: 50,
                padding: EdgeInsets.all(0),
                leftChild: Container(
                  width: 30,
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: icontupian15(
                          color: rgba(220, 220, 220, 1), size: 20)),
                ),
                centerChild: Text('兑换优惠'),
                rightChild:
                    icontupian6(color: rgba(228, 228, 228, 1), size: 14),
                onPressed: () => Global.pushNamed('/dining_code'),
              ),
              ARow(
                height: 50,
                padding: EdgeInsets.all(0),
                leftChild: Container(
                  width: 30,
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child:
                          icontupian9(color: rgba(220, 220, 220, 1), size: 20)),
                ),
                centerChild: Text('发票管理'),
                rightChild:
                    icontupian6(color: rgba(228, 228, 228, 1), size: 14),
                border: Global.borderBottom(show: false),
              ),
            ],
          ),
        ),
        ARow(
          height: 50,
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.symmetric(horizontal: 15),
          leftChild: Container(
            width: 30,
            alignment: Alignment.centerLeft,
            child: Container(
                child: iconshoucang(color: rgba(220, 220, 220, 1), size: 20)),
          ),
          centerChild: Text('帮助反馈'),
          rightChild: icontupian6(color: rgba(228, 228, 228, 1), size: 14),
          border: Global.borderBottom(show: false),
        ),
        Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Image.asset(
              'assets/images/mine/mine2.jpg',
              fit: BoxFit.cover,
            ))
      ],
    ));
  }
}
