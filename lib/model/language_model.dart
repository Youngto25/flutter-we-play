import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Map<String, String> zh = {"nickname": "昵称", "welcome": "欢迎来到"};
Map<String, String> en = {"nickname": "nickname", "welcome": "welcome"};

class Language with ChangeNotifier, DiagnosticableTreeMixin {
  Map<String, String> _language = zh;
  Map<String, String> get language => _language;

  void changeLanguage({String type}) {
    if (type == "zh") {
      _language = zh;
    }
    if (type == "en") {
      _language = en;
    }
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('language', language));
  }
}
