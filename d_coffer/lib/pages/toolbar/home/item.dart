import 'package:color_dart/RgbaColor.dart';
import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  const HomeItem(
      {Key key, this.rightIcon, this.title, this.detail, this.onPressed})
      : super(key: key);

  final Widget rightIcon;
  final String title;
  final String detail;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () => onPressed == null ? () {} : onPressed(),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 1, color: rgba(242, 242, 242, 1))),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      color: rgba(56, 56, 56, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  detail,
                  style: TextStyle(color: rgba(128, 128, 128, 1), fontSize: 12),
                ),
              ],
            ),
            rightIcon
          ],
        ),
      ),
    );
  }
}
