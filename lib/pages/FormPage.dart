import 'package:flutter/material.dart';

class FormPage extends StatelessWidget {
  final arguments;
  FormPage({this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('表单')
      ),
      body: Text('form page${this.arguments != null ? this.arguments['pid'] : 0}'),
    );
  }
}