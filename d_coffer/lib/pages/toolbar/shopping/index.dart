import 'package:color_dart/HexColor.dart';
import 'package:color_dart/RgbaColor.dart';
import 'package:d_coffer/components/a_dialog/a_dialog.dart';
import 'package:d_coffer/components/customAppbar.dart';
import 'package:d_coffer/jsonserialize/goods_list/data.dart';
import 'package:d_coffer/jsonserialize/order/data.dart';
import 'package:d_coffer/jsonserialize/shopping_cart/data.dart';
import 'package:d_coffer/pages/toolbar/menu/detail/FoodsDialog.dart';
import 'package:d_coffer/pages/toolbar/menu/detail/a_buttom.dart';
import 'package:d_coffer/pages/toolbar/shopping/widgets/recommend_goods.dart';
import 'package:d_coffer/pages/toolbar/shopping/widgets/shopping_cart_row.dart';
import 'package:d_coffer/provider/ShoppingCartModel.dart';
import 'package:d_coffer/provider/order_model.dart';
import 'package:d_coffer/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tableview/flutter_tableview.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class Shopping extends StatefulWidget {
  // Shopping({Key key}) : super(key: key);

  static _ShoppingState _shoppingState;

  getAppBar() => _shoppingState.createAppBar();

  Shopping() {
    if (_shoppingState == null) {
      _shoppingState = _ShoppingState();
    }
  }
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  GoodsList goodsList;

  final orderBy = [
    'priceUp',
    'priceDown',
    'ordersUp',
    'ordersDown',
    'addedUp',
    'addDown'
  ];

  AppBar createAppBar() {
    /// 配置appbar
    return customAppbar(title: '购物车');
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      getGoodsList(context);
    });
  }

  getGoodsList(BuildContext context) async {
    Global.loading.show(context);
    var reg = math.Random();

    int index = reg.nextInt(5);

    try {
      var res = await Global.req.shop
          .goodsList(orderBy: orderBy[index], page: 1, pageSize: 3);

      Map result = res.data;
      setState(() {
        goodsList = GoodsList.fromJson(result);
      });
    } catch (e) {
      print(e);
    }
    Global.loading.hide(context);
  }

  /// 购物车商品
  List<Widget> buildShoppingCartList(ShoppingCartModel _shoppingCartModel,
      Map<String, ShoppingCartData> shoppingCartData) {
    List<Widget> shoppingCartList = [];
    List _list = shoppingCartData.keys.toList();
    int _listLen = _list.length;

    _list.asMap().forEach((index, key) {
      ShoppingCartData value = shoppingCartData[key];

      shoppingCartList.add(ShoppingCartRow(
        data: value,
        border: index >= _listLen - 1 ? false : true,
        onCheckBoxChange: (bool val) {
          setState(() {
            value.checked = val;
            _shoppingCartModel.modify(key, data: value);
          });
        },
        onChange: (val) {
          if (val < 1) {
            ADialog.confirm(
              context,
              content: '确认不要了吗？',
              confirmButtonPress: () {
                setState(() {
                  _shoppingCartModel.remove(key);
                });
              },
            );
          } else {
            setState(() {
              value.number = val;
              _shoppingCartModel.modify(key, data: value);
            });
          }
        },
      ));
    });

    return shoppingCartList;
  }

  /// 购物车为空
  Container shoppingCartNotData() {
    return Container(
        margin: EdgeInsets.only(bottom: 50),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/shopping_cart_null.png',
              width: 125,
              fit: BoxFit.contain,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 32),
              child: Text(
                '您的购物车有点寂寞',
                style: TextStyle(color: rgba(166, 166, 166, 1), fontSize: 12),
              ),
            ),
            AButton.normal(
                width: 100,
                height: 30,
                type: 'info',
                color: rgba(144, 192, 239, 1),
                borderColor: rgba(144, 192, 239, 1),
                plain: true,
                child: Text('去喝一杯'),
                onPressed: () => Global.pushNamed('/menu'))
          ],
        ));
  }

  /// 猜你喜欢
  Container guessLike(ShoppingCartModel model) {
    return goodsList == null
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            margin: EdgeInsets.only(top: 15),
            child: Column(
              children: <Widget>[
                // title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '猜你喜欢',
                      style: TextStyle(
                          color: rgba(56, 56, 56, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      child: Row(
                        children: <Widget>[
                          icontupian19(color: rgba(148, 196, 236, 1), size: 14),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text(
                              '换一批',
                              style: TextStyle(
                                  color: rgba(144, 192, 239, 1), fontSize: 11),
                            ),
                          )
                        ],
                      ),
                      onTap: () => getGoodsList(context),
                    )
                  ],
                ),

                // 推荐商品
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: goodsList.data.map((GoodsListDatum item) {
                      return RecommendGoods(
                          data: item,
                          onPress: (int id) {
                            /// 弹出商品详情  /widgets/goods_detail
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return FoodsDialog(
                                    id: id,
                                    model: model,
                                  );
                                });
                          });
                    }).toList(),
                  ),
                )
              ],
            ),
          );
  }

  /// 底部合计
  Container buttomBtnRow(
    bool shoppingCartIsEmpty,
    num totalPrice, {
    ShoppingCartModel shoppingCartModel,
    OrderModel orderModel,
  }) {
    return Container(
      child: shoppingCartIsEmpty
          ? null
          : Container(
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1, color: rgba(242, 242, 242, 1))),
                color: hex('#fff'),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // left
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            '应付合计',
                            style: TextStyle(
                                color: rgba(56, 56, 56, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            '¥$totalPrice',
                            style: TextStyle(
                                color: rgba(56, 56, 56, 1),
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),

                  // right button
                  AButton.normal(
                      child: Text('去结算'),
                      color: hex('#fff'),
                      bgColor: rgba(144, 192, 239, 1),
                      width: 120,
                      height: 60,
                      borderRadius: BorderRadius.zero,
                      onPressed: () {
                        Map<String, ShoppingCartData> shoppingCartModelData =
                            shoppingCartModel.data;
                        // Map<String, OrderData> orderModel =

                        List<OrderData> requestData = [];

                        shoppingCartModelData.values
                            .forEach((ShoppingCartData val) {
                          if (val.checked) {
                            Map<String, dynamic> jsonData = {
                              "goodsId": val.id,
                              "number": val.number,
                              "propertyChildIds": val.spec,
                              "logisticsType": 0,
                              "days": [DateTime.now().toString().split(' ')[0]]
                            };

                            requestData.add(OrderData.fromJson(jsonData));
                          }
                        });

                        /// 没有选中商品
                        if (requestData.isEmpty) {
                          Global.toast('没有要结算的商品');
                        } else {
                          orderModel.init(requestData);
                          Global.pushNamed('/order_confirm');
                        }
                      })
                ],
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ShoppingCartModel _shoppingCartModel =
        Provider.of<ShoppingCartModel>(context);
    OrderModel _orderModel = Provider.of<OrderModel>(context);
    Map<String, ShoppingCartData> shoppingCartData = _shoppingCartModel.data;
    num totalPrice = _shoppingCartModel.totalPrice;

    bool shoppingCartIsEmpty = shoppingCartData.isEmpty;
    return Container(
      color: hex('#f7f7f7'),
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                          child: !shoppingCartIsEmpty
                              ? Image.asset(
                                  'assets/images/order/order1.png',
                                  fit: BoxFit.cover,
                                )
                              : null),

                      // 购物车列表展示
                      Container(
                          color: hex('#fff'),
                          child: shoppingCartIsEmpty
                              ? null
                              : Column(
                                  children: buildShoppingCartList(
                                      _shoppingCartModel, shoppingCartData))),

                      Center(
                          child: shoppingCartIsEmpty
                              ? shoppingCartNotData()
                              : null),

                      guessLike(_shoppingCartModel),
                    ],
                  )),
            ),
          ),
          buttomBtnRow(shoppingCartIsEmpty, totalPrice,
              shoppingCartModel: _shoppingCartModel, orderModel: _orderModel)
        ],
      ),
    );
  }
}
