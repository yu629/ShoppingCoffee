/*
 * @Author: meetqy
 * @since: 2019-08-06 11:35:23
 * @lastTime: 2019-11-22 15:23:58
 * @LastEditors: meetqy
 */

import 'package:color_dart/color_dart.dart';
import 'package:d_coffer/pages/toolbar/home/index.dart';
import 'package:d_coffer/pages/toolbar/menu/index.dart';
import 'package:d_coffer/pages/toolbar/mine/index.dart';
import 'package:d_coffer/pages/toolbar/order/index.dart';
import 'package:d_coffer/pages/toolbar/shopping/index.dart';
import 'package:d_coffer/utils/Icon.dart';
import 'package:flutter/material.dart';


class Toolbar extends StatefulWidget {
  final String routeName;
  final Object arguments;

  // 初始化所有的toolbar页面
  static Home _home = Home();
  static Menu _menu = Menu();
  static Order _order = Order();
  static Shopping _shoppingCart = Shopping();
  static Mine _mine = Mine();

  /// 所有toolbar页面
  final Map<int, Map> pages = {
    0: _createPage(_home, appbar: _home.getAppBar(), routeName: '/'),
    1: _createPage(_menu, appbar: _menu.getAppBar(), routeName: '/menu'),
    2: _createPage(_order, appbar: _order.getAppBar(), routeName: '/order'),
    3: _createPage(_shoppingCart, appbar: _shoppingCart.getAppBar(), routeName: '/shopping_cart'),
    4: _createPage(_mine, appbar: _mine.getAppBar(), routeName: '/mine')
  };


  /// 创建页面map
  /// ```
  /// @param {Widget} page - 页面
  /// @param {Appbar} appbar - 当前页面是否显示appbar 默认为true
  /// ```
  static Map _createPage(Widget page, { AppBar appbar, String routeName}) {
    return {
      "widget": page,
      "appbar": appbar,
      "routeName": routeName
    };
  }

  static Toolbar _singleton;

  Toolbar.singleton({
    this.routeName,
    this.arguments
  });

  factory Toolbar({
    String routeName,
    Object arguments
  }) {
    if(_singleton == null) {
      _singleton = Toolbar.singleton(routeName: routeName, arguments: arguments,);
    }

    return _singleton;
  }


  // 通过 routeName 获取对应页面的索引
  getPageIndex(routeName) {
    switch(routeName) {
      case '/menu': return 1;
      case '/order': return 2;
      case '/shopping_cart': return 3;
      case '/mine': return 4;
      default: return 0;
    }
  }


  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Toolbar> {
  static int currentIndex =  0;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      String routeName = ModalRoute.of(context).settings.name;
      setState(() {
        currentIndex = widget.getPageIndex(routeName);
      });
    });
  }

  Widget renderText(text) {
    return new Container( child: new Text(text),
              margin: const EdgeInsets.only(top: 10.0));
  }

  @override
  Widget build(BuildContext context) {
    Map page = widget.pages[currentIndex];
    return Scaffold(
      appBar: page['appbar'],
      body: Container(
        color: hex('#fff'),
        child: page['widget']
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: iconlogoNotText(size: 25),
              title: this.renderText('首页')),
            BottomNavigationBarItem(icon: iconcaidan(size: 25),title: this.renderText('菜单'),),
            BottomNavigationBarItem(icon: iconorder(size: 25),title: this.renderText('订单'),),
            BottomNavigationBarItem(icon: icongouwuche(size: 25),title: this.renderText('购物车'),),
            BottomNavigationBarItem(icon: iconmine(size: 25),title: this.renderText('我的'),),
          ],
          unselectedFontSize: 14, // 未选中字体大小
          selectedFontSize: 14, // 选中字体大小
          selectedItemColor: rgba(43, 76, 126, 1), // 选中字体颜色
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        )
      )
    );
  }
}