import 'package:color_dart/RgbaColor.dart';
import 'package:flutter/material.dart';

class TakeOutIn extends StatefulWidget {
  TakeOutIn({Key key}) : super(key: key);

  @override
  _TakeOutInState createState() => _TakeOutInState();
}

class _TakeOutInState extends State<TakeOutIn> {
  bool _counter = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print('object');
          setState(() {
            _counter = !_counter;
          });
        },
        child: Container(
            width: 96,
            height: 36,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                border: Border.all(color: rgba(136, 175, 213, 1)),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: 44,
                  height: 30,
                  child: Text(
                    '自提',
                    style: TextStyle(
                        fontSize: 12,
                        color:
                            _counter ? rgba(136, 175, 213, 1) : Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                      color: _counter ? Colors.white : rgba(136, 175, 213, 1),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 44,
                  height: 30,
                  child: Text(
                    '外卖',
                    style: TextStyle(
                        fontSize: 12,
                        color:
                            _counter ? Colors.white : rgba(136, 175, 213, 1)),
                    textAlign: TextAlign.center,
                  ),
                  decoration: BoxDecoration(
                      color: _counter ? rgba(136, 175, 213, 1) : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
              ],
            )));
  }
}

// Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Text('自提', style: TextStyle(fontSize: 12, color: rgba(136, 175, 213, 1)),),
//             Text('外卖', style: TextStyle(fontSize: 12, color: rgba(136, 175, 213, 1)),),
//           ],
//         ),
