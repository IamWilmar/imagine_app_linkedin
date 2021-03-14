
import 'package:flutter/cupertino.dart';

/*
  Provider para controlar el radioButton Seleccionado
  Se usan en el modal para cambiar privacidad
  en la pagina de creacion de Post
 */

class RadioProvider with ChangeNotifier{
  int _radioValue = 0;

  int get radioValue => this._radioValue;

  set radioValue(int radioValue) {
    this._radioValue = radioValue;
    notifyListeners(); //notifica cambios de este provider a los widgets que los escuchan.
  }
}