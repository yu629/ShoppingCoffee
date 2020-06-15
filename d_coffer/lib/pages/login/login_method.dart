import 'package:color_dart/color_dart.dart';
import 'package:d_coffer/components/customAppbar.dart';
import 'package:d_coffer/pages/toolbar/menu/detail/a_buttom.dart';
import 'package:d_coffer/utils/global.dart';
import 'package:flutter/material.dart';


class LoginMethod extends StatelessWidget {
  const LoginMethod({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, borderBottom: false),

      body: Container(
        width: Global.screenWidth(),
        color: hex('#fff'),
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 26),
            width: 80,
            height: 94,
            child: Image.asset('assets/images/logo1.png', fit: BoxFit.cover,),
          ),

          Container(
            margin: EdgeInsets.only(top: 116),
            child: AButton.normal(
              width: 300,
              child: Text('微信一键登录'),
              color: hex('#fff'),
              bgColor: rgba(73, 194, 101, 1),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            child: AButton.normal(
              width: 300,
              child: Text('邮箱验证码登录'),
              color: rgba(136, 175, 213, 1),
              bgColor: hex('#fff'),
              borderColor: rgba(136, 175, 213, 1),
              plain: true,
              onPressed: () => Global.pushNamed('/login_mail')
            ),
          ),
          
        ],),
      ),
    );
  }
}