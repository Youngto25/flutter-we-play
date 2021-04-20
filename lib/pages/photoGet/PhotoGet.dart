import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoGet extends StatefulWidget {
  PhotoGet({Key key}) : super(key: key);

  @override
  _PhotoGetState createState() => _PhotoGetState();
}

class _PhotoGetState extends State<PhotoGet> {
  File _image;
  final picker = ImagePicker();
  String theTime = "欢迎";
  Timer timer;

  @override
  void initState() {
    this.initTimeNow();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // 时间显示
  void initTimeNow() {
    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      DateTime now = new DateTime.now();
      theTime = now.year.toString() +
          '-' +
          this.timeAddZero(now.month.toString()) +
          '-' +
          this.timeAddZero(now.day.toString()) +
          ' ' +
          this.timeAddZero(now.minute.toString()) +
          ':' +
          this.timeAddZero(now.second.toString());
      this.setState(() {});
    });
  }

  // 为时间加0
  String timeAddZero(String time) {
    String t = time;
    if (t.length == 1) {
      t = '0' + t;
    }
    return t;
  }

// 拍照，单张
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  // 选择图片，单张
  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  // 选择图片，单张
  Future theImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
    // String info = _image.readAsStringSync();
    print(["info======>", _image]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50.0,
          title: Stack(
            alignment: Alignment.center,
            children: [
              Container(child: Center(child: Text(theTime))),
              Positioned(
                  right: 0,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.close)))
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(onPressed: pickImage, child: Text('选择图片，单张')),
                RaisedButton(onPressed: getImage, child: Text('拍照，单张')),
                _image == null
                    ? Container()
                    : Semantics(
                        child: Image.file(_image),
                        label: 'image_picker_example_picked_image')
              ]),
        ));
  }
}
