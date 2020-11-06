import 'package:flutter/material.dart';

class PinList extends StatefulWidget {
  int category;
  PinList(this.category, {Key key}) : super(key: key);

  @override
  _PinListState createState() => _PinListState(this.category);
}

class _PinListState extends State<PinList> with AutomaticKeepAliveClientMixin {
  int category;
  _PinListState(this.category);
  List<Widget> _list() {
    List<Widget> list = new List();
    for (var i = 0; i < 20; i++) {
      list.add(ListTile(
        title: Text('hello $category'),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: this._list(),
      ),
    );
  }
  bool get wantKeepAlive => true;
}
