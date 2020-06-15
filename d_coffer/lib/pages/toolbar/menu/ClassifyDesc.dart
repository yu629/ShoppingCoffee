import 'package:color_dart/RgbaColor.dart';
import 'package:flutter/material.dart';
class ClassifyDesc extends StatelessWidget {
  const ClassifyDesc({Key key, this.name, this.desc}) : super(key: key);

  final String name;
  final String desc;

  _createNotDesc(String name) {
    return Container(child:
      Row(children: <Widget>[
        Text(name, style: TextStyle(
          fontSize: 12,
          color: rgba(56, 56, 56, 1),
          fontWeight: FontWeight.bold
        ),),
        Expanded(child:
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 1,
            color: rgba(242, 242, 242, 1),
          )
        ,)
      ],)
    );
  }

  _create(String name, String desc) {
    return Column(children: <Widget>[
      Row(children: <Widget>[
        Expanded(child: Text(name, style: TextStyle(
          fontSize: 12,
          color: rgba(56, 56, 56, 1),
          fontWeight: FontWeight.bold
        ),),)
      ],),

      Row(children: <Widget>[
        Text(desc, style: TextStyle(
          fontSize: 10,
          color: rgba(166, 166, 166, 1),
        ),),
        Expanded(child:
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 1,
            color: rgba(242, 242, 242, 1),
          )
        ,)
      ],)
    ],);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: desc == null ? _createNotDesc(name) : _create(name, desc),
    );
  }
}