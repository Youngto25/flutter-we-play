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
