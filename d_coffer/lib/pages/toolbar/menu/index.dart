import 'package:color_dart/RgbaColor.dart';
import 'package:d_coffer/components/swip/index.dart';
import 'package:d_coffer/jsonserialize/goods_category/data.dart';
import 'package:d_coffer/jsonserialize/goods_list/data.dart';
import 'package:d_coffer/pages/toolbar/menu/Category.dart';
import 'package:d_coffer/pages/toolbar/menu/ClassifyDesc.dart';
import 'package:d_coffer/pages/toolbar/menu/detail/FoodsDialog.dart';
import 'package:d_coffer/pages/toolbar/menu/good_list_item.dart';
import 'package:d_coffer/provider/ShoppingCartModel.dart';
import 'package:d_coffer/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tableview/flutter_tableview.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  static _MenuState _menuState;

  getAppBar() => _menuState.createAppBar();

  Menu() {
    _menuState = _MenuState();
  }

  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final ScrollController _nestedScrollController = new ScrollController();
  final ScrollController _controller = new ScrollController();
  FlutterTableView flutterTableView;
  static int nowCategoryId;
  static double _nestedScrollOffet = 0;
  GoodsList goodsLists;
  List<GoodsCategoryDatum> category = [];
  List<Widget> goodsListWidgets = [];

  List<int> scrollIndex = [];

  AppBar createAppBar() {
    return null;
  }

  @override
  void initState() {
    super.initState();
    _nestedScrollController.addListener(() {
      setState(() {
        _nestedScrollOffet = _nestedScrollController.offset;
      });
    });
    _controller.addListener(() {
      // print(_controller.offset); //打印滚动位置
      int current = 0;
      int currentVar = 0;
      scrollIndex.forEach((f) => {
            if (_controller.offset > f) {currentVar = f}
          });
      current = scrollIndex.indexOf(currentVar, 0);
      if (current < category.length) {
        setState(() {
          nowCategoryId = category[current].id;
        });
      }
    });

    Future.delayed(Duration.zero, () {
      _init(context);
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    _nestedScrollController.dispose();
    super.dispose();
  }

  _init(BuildContext context) async {
    try {
      Iterable<Future> requestList = [
        Global.req.shop.goodsList(),
        Global.req.shop.goodsCategoryAll(),
      ];
      List result = await Future.wait(requestList);
      GoodsList goodsList = GoodsList.fromJson(result[0].data);
      GoodsCategory goodsCategory = GoodsCategory.fromJson(result[1].data);
      List<int> listIndex = [];
      List<Widget> goodsListWidgetsTemp = [];
      listIndex.add(0);
      goodsCategory.data.forEach((GoodsCategoryDatum category) {
        int num = 0;
        goodsList.data.asMap().forEach((int index, GoodsListDatum goods) {
          if (category.id == goods.categoryId) {
            num += 1;
          }
        });
        int all = listIndex.length == 0 ? 0 : listIndex[listIndex.length - 1];
        listIndex.add(all + num * 98 + 34);
      });
      setState(() {
        category = goodsCategory.data;
        nowCategoryId = goodsCategory.data[0].id;
        goodsListWidgets = goodsListWidgetsTemp;
        scrollIndex = listIndex;
        goodsLists = goodsList;
      });
      // Global.loading.hide(context);
    } catch (e) {
      print(e);
      // Global.loading.hide(context);
    }
  }

  int _rowCountAtSection(int section) {
    int num = 0;
    if (section < category.length) {
      GoodsCategoryDatum cate = category[section];
      goodsLists.data.forEach((va) => {
            if (va.categoryId == cate.id) {num += 1}
          });
    }
    return num;
  }

  Widget _sectionHeaderBuilder(BuildContext context, int section) {
    if (section < category.length) {
      GoodsCategoryDatum cate = category[section];
      return ClassifyDesc(
        name: cate.name,
        desc: null,
      );
    }
    return null;
  }

  // cell item widget builder.
  Widget _cellBuilder(BuildContext context, int section, int row) {
    int goodsListLen = goodsLists.data.length;
    if (section < category.length) {
      GoodsCategoryDatum cate = category[section];
      List<GoodsListDatum> list = [];
      goodsLists.data.forEach((va) => {
            if (va.categoryId == cate.id) {list.add(va)}
          });
      if (row < list.length) {
        return GoodsListItem(
          onPress: (BuildContext context, int id) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  final ShoppingCartModel _shoppingCartModel =
                      Provider.of<ShoppingCartModel>(context);
                  return FoodsDialog(
                    id: id,
                    model: _shoppingCartModel,
                  );
                });
            // Global.pushNamed('/food_detail', arguments: { 'detail' : id });
          },
          data: list[row],
          border: !(row >= goodsListLen - 1),
          activeDesc: row % 2 == 1,
        );
      }
    }
    return null;
  }

  // Each section header height;
  double _sectionHeaderHeight(BuildContext context, int section) {
    return 34.0;
  }

  // Each cell item widget height.
  double _cellHeight(BuildContext context, int section, int row) {
    return 98.0;
  }

  Widget renderListTable() {
    flutterTableView = FlutterTableView(
        controller: _controller,
        sectionCount: category.length == 0 ? 1 : category.length,
        rowCountAtSection: _rowCountAtSection,
        sectionHeaderBuilder: _sectionHeaderBuilder,
        cellBuilder: _cellBuilder,
        sectionHeaderHeight: _sectionHeaderHeight,
        cellHeight: _cellHeight,
        physics: _nestedScrollOffet >= 130
            ? BouncingScrollPhysics()
            : ClampingScrollPhysics());
    return flutterTableView;
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        controller: _nestedScrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
                expandedHeight: 216,
                pinned: true,
                floating: false,
                elevation: 0,
                bottom: PreferredSize(
                  child: Container(
                    decoration: BoxDecoration(border: Global.borderBottom()),
                  ),
                  preferredSize: Size.fromHeight(0),
                ),
                title: Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: Text(
                    '选择咖啡和小食',
                    style: TextStyle(
                        color: rgba(56, 56, 56, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    margin: EdgeInsets.only(top: 86),
                    child: InkWell(
                      child: Opacity(
                        opacity: 1,
                        child: CustomSwiper([
                          'assets/images/menu/swiper1.jpg',
                          'assets/images/menu/swiper2.png',
                        ], height: 130),
                      ),
                      onTap: () {},
                    ),
                  ),
                ))
          ];
        },
        body: Container(
          padding: EdgeInsets.only(
              top: _nestedScrollOffet >= 160 ? (_nestedScrollOffet - 160) : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 90,
                color: rgba(248, 248, 248, 1),
                child: Category(
                  categoryData: category,
                  categoryId: nowCategoryId,
                  onCategroyPress: (vad) {
                    if (nowCategoryId != vad.id) {
                      var ca = category.indexOf(vad, 0);
                      setState(() {
                        nowCategoryId = vad.id;
                      });
                      _controller.animateTo(
                          double.parse(scrollIndex[ca].toString()),
                          duration: Duration(milliseconds: 200),
                          curve: Curves.ease);
                    }
                  },
                ),
              ),
              MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: Container(
                  width: Global.screenWidth() - 90,
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: this.renderListTable(),
                  // child: SingleChildScrollView(
                  //   controller: _controller,
                  //   child: Column(
                  //     children: goodsListWidgets,
                  //   ),
                  //   physics: _nestedScrollOffet >= 130
                  //       ? BouncingScrollPhysics()
                  //       : ClampingScrollPhysics(),
                  //   // child: goodsListWidgets,
                  // ),
                ),
              )
            ],
          ),
        ));
  }
}
