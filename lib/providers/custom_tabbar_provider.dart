import 'package:flutter/cupertino.dart';

/*
  Provider para mantener el indexactual del tabbar
  en la Home
*/

class CustomtabBarProvider with ChangeNotifier{
  int _index = 0;

  //Getter y Setter
  int get index => this._index;

  set index(int index) {
    this._index = index;
    notifyListeners(); //Notifica a todos los widgets que escuchen a este provider
  }
}