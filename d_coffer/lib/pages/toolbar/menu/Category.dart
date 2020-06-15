import 'package:color_dart/HexColor.dart';
import 'package:d_coffer/jsonserialize/goods_category/data.dart';
import 'package:d_coffer/utils/global.dart';
import 'package:flutter/material.dart';


class Category extends StatelessWidget {
  Category({Key key, this.categoryId, this.categoryData, this.onCategroyPress})
      : super(key: key);

  final int categoryId;
  final List<GoodsCategoryDatum> categoryData;
  final Function onCategroyPress;

  List<Widget> _render() {
    List<Widget> widgets = [];

    categoryData.forEach((val) {
      widgets.add(InkWell(
        // key: Key('${val.id}'),
        onTap: () => onCategroyPress(val),
        child: Container(
          alignment: Alignment.center,
          height: 44,
          decoration: BoxDecoration(
              border: Global.borderBottom(show: categoryId == val.id),
              color: hex('#fff').withOpacity(categoryId == val.id ? 1.0 : 0.0)
              ),
          child: Text(val.name),
        ),
      ));
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _render(),
    );
  }
}
