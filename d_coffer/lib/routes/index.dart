import 'package:d_coffer/pages/coupon/index.dart';
import 'package:d_coffer/pages/diningcode/index.dart';
import 'package:d_coffer/pages/login/login_mail.dart';
import 'package:d_coffer/pages/login/login_method.dart';
import 'package:d_coffer/pages/login/user_agreement.dart';
import 'package:d_coffer/pages/order/order_confirm.dart';
import 'package:d_coffer/pages/order/order_detail.dart';
import 'package:d_coffer/pages/order/order_evaluation.dart';
import 'package:d_coffer/pages/order/order_remark.dart';
import 'package:d_coffer/pages/selfStore/index.dart';
import 'package:d_coffer/pages/storedetail/index.dart';
import 'package:d_coffer/pages/toolbar/index.dart';
import 'package:d_coffer/pages/toolbar/menu/detail/FoodsDetail.dart';
import 'package:flutter/material.dart';




class Router {
  static final _routes = {
    // 从非toolbar页面跳转到toolbar页面的入场动画不一致
    // 从非toolbar页面（子页面）跳转到toolbar页面（主页）实现：
    // pushName到对应的路由，因为Toolbar是单例模式，所以只会创建一个
    // pushName之后，在ToolBar，initState中获取当前的路由，实现切换页面
    '/': (BuildContext context, { Object args }) => Toolbar(),
    '/mine': (BuildContext context, { Object args }) => Toolbar(),
    '/order': (BuildContext context, { Object args }) => Toolbar(),
    '/shopping_cart': (BuildContext context, { Object args }) => Toolbar(),
    '/menu': (BuildContext context, { Object args }) => Toolbar(arguments: args,),

    '/food_detail': (BuildContext context, { Object args }) => FoodsDetail(args: args,),
    '/order_evaluation': (BuildContext context, { Object args }) => OrderEvaluation(),
    '/order_confirm': (BuildContext context, { Object args }) => OrderConfirm(),
    '/order_remark': (BuildContext context, { Object args }) => OrderRemark(),
    '/order_detail': (BuildContext context, { Object args }) => OrderDetail(args: args,),
    '/coupon': (BuildContext context, { Object args }) => Coupon(),
    '/self_store': (BuildContext context, { Object args }) => SelfStore(),
    '/store_detail': (BuildContext context, { Object args }) => StoreDetail(),
    '/dining_code': (BuildContext context, { Object args }) => DiningCode(),
    '/login_method': (BuildContext context, { Object args }) => LoginMethod(),
    '/login_mail': (BuildContext context, { Object args }) => LoginMail(),
    '/user_agreement': (BuildContext context, { Object args }) => UserAgreement(),
  };

  static Router _singleton;

  Router._internal();

  factory Router() {
    if(_singleton == null) {
      _singleton = Router._internal();
    }

    return _singleton;
  }

  /// 监听route
  Route getRoutes(RouteSettings settings) {
    String routeName = settings.name;
    final Function builder = Router._routes[routeName];

    print(settings);

    if(builder == null) {
      return null;
    } else {
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => builder(context, args: settings.arguments)
      );
    }
  }
}
