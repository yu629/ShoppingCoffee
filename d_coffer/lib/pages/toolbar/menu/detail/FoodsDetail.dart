import 'package:flutter/material.dart';


class FoodsDetail extends StatefulWidget {
  FoodsDetail({Key key, this.args}) : super(key: key);

  final Map args;
  @override
  _FoodsDetailState createState() => _FoodsDetailState();
}

class _FoodsDetailState extends State<FoodsDetail> {
  static Map args;

  @override
  void initState() {
    super.initState();

    setState(() {
      args = widget.args;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args['detail'].toString()),
      ),
    );
  }
}