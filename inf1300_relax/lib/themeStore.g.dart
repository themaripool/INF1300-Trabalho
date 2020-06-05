// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'themeStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ThemeStore on _ThemeStore, Store {
  final _$themeStoreAtom = Atom(name: '_ThemeStore.themeStore');

  @override
  ThemeData get themeStore {
    _$themeStoreAtom.reportRead();
    return super.themeStore;
  }

  @override
  set themeStore(ThemeData value) {
    _$themeStoreAtom.reportWrite(value, super.themeStore, () {
      super.themeStore = value;
    });
  }

  final _$_ThemeStoreActionController = ActionController(name: '_ThemeStore');

  @override
  void switchTheme() {
    final _$actionInfo = _$_ThemeStoreActionController.startAction(
        name: '_ThemeStore.switchTheme');
    try {
      return super.switchTheme();
    } finally {
      _$_ThemeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
themeStore: ${themeStore}
    ''';
  }
}
