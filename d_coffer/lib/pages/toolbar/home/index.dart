import 'package:color_dart/HexColor.dart';
import 'package:color_dart/RgbaColor.dart';
import 'package:d_coffer/components/swip/index.dart';
import 'package:d_coffer/pages/toolbar/home/item.dart';
import 'package:d_coffer/pages/toolbar/home/takeOutIn.dart';
import 'package:d_coffer/utils/global.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  static _HomeState _homeState;

  Home() {
    _homeState = _HomeState();
  }

  getAppBar() => _homeState.createAppBar();

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AppBar createAppBar() {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Positioned(
                child: CustomSwiper(
                  [
                    'assets/images/home/swiper1.jpg',
                    'assets/images/home/swiper2.jpg',
                    'assets/images/home/swiper3.jpg',
                  ],
                  height: Global.screenHeight() > 800 ? 288 : 208,
                ),
              ),
              Positioned(
                top: 50,
                right: 10,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: rgba(0, 0, 0, .3),
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: icontupian4(size: 20, color: hex('#fff')),
                  ),
                ),
              )
            ],
          ),
          HomeItem(
            title: '火车南站',
            detail: '距您53m',
            rightIcon: TakeOutIn(),
            onPressed: () => {}
          ),
          HomeItem(
            title: '现在下单',
            detail: 'ORDER NOW',
            rightIcon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: rgba(99, 71, 58, 1)),
                  borderRadius: BorderRadius.circular(20)),
              child: icontupian3(color: rgba(99, 71, 58, 1), size: 20),
            ),
            onPressed: () => {}
          ),
          HomeItem(
            title: '咖啡钱包',
            detail: 'COFFRR WALLET',
            rightIcon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: rgba(99, 71, 58, 1)),
                  borderRadius: BorderRadius.circular(20)),
              child: icontupian(color: rgba(99, 71, 58, 1), size: 20),
            ),
            onPressed: () => {}
          ),
          HomeItem(
            title: '送Ta咖啡',
            detail: 'SEND COFFEE',
            rightIcon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: rgba(99, 71, 58, 1)),
                  borderRadius: BorderRadius.circular(20)),
              child: icontupian1(color: rgba(99, 71, 58, 1), size: 20),
            ),
            onPressed: () => {}
          ),
          HomeItem(
            title: '组件列表',
            detail: 'CONPONENTS LIST',
            rightIcon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: rgba(99, 71, 58, 1)),
                  borderRadius: BorderRadius.circular(20)),
              child: iconorder(color: rgba(99, 71, 58, 1), size: 20),
            ),
            onPressed: () => {}
          ),
          Container(
              child: Image.asset('assets/images/home/bottom_bar.png'),
          )
        ],
      ),
    );
  }
}
