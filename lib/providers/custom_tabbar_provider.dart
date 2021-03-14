
import 'package:flutter/cupertino.dart';

class CustomtabBarProvider with ChangeNotifier{
  int _index = 0;

  int get index => this._index;

  set index(int index) {
    this._index = index;
    notifyListeners();
  }
}