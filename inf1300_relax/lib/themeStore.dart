import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'themeStore.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {

  @observable 
  ThemeData themeStore = ThemeData.fallback();

  @action 
  void switchTheme() {

    if (themeStore == ThemeData.fallback()){
      themeStore = ThemeData.dark();
    } else {
      themeStore = ThemeData.fallback();
    }

  }
}