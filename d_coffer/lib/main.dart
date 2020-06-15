import 'dart:convert';

import 'package:color_dart/color_dart.dart';
import 'package:d_coffer/provider/ShoppingCartModel.dart';
import 'package:d_coffer/provider/counter_model.dart';
import 'package:d_coffer/provider/order_model.dart';
import 'package:d_coffer/routes/index.dart';
import 'package:d_coffer/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _shoppingCart;

final Router router = Router();
// WidgetsFlutterBinding.ensureInitialized();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _shoppingCart = prefs.getString('shoppingCart');
  String user = prefs.getString('user');

  if (user != null && user.isNotEmpty) {
    /// 初始化user
    Global.user.init(json.decode(user));
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: CounterModel()),
        ChangeNotifierProvider.value(value: ShoppingCartModel()),
        ChangeNotifierProvider.value(value: OrderModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    final ShoppingCartModel _shoppingCartModel =
        Provider.of<ShoppingCartModel>(context);

    if (_shoppingCart != null) {
      Map data = json.decode(_shoppingCart);
      _shoppingCartModel.init(data);
    }
    return MaterialApp(
      navigatorKey: Global.navigatorKey,
      title: 'Flutter Luckin Coffee',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(
            color: rgba(0, 0, 0, 0),
          ),
          elevation: 0
        ),
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: router.getRoutes,
    );
  }
}
