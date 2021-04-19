import 'package:flutter/material.dart';

class AppBarX extends StatefulWidget implements PreferredSizeWidget {
  final double contentHeight = 50.0;
  final String title;
  final double elevation;
  AppBarX({Key key, this.title, this.elevation = 0.4}) : super(key: key);

  @override
  _AppBarXState createState() => _AppBarXState();

  @override
  Size get preferredSize => Size.fromHeight(contentHeight);
}

class _AppBarXState extends State<AppBarX> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AppBar(
        title: Text(this.widget.title),
        toolbarHeight: this.widget.contentHeight,
        elevation: this.widget.elevation,
      ),
    );
  }
}
