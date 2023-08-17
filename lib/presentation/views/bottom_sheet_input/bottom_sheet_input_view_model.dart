import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomSheetInputViewModel extends ChangeNotifier {
  String? _title;
  String? _description;

  String get title => _title ?? '';
  String get description => _description ?? '';

  setTitle(value) {
    _title = value;
    notifyListeners();
  }

  setDescription(value) {
    _description = value;
    notifyListeners();
  }

  getToJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
