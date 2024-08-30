// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_navigator_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BottomNavigatorController on _BottomNavigatorControllerBase, Store {
  Computed<int>? _$currentIndexComputed;

  @override
  int get currentIndex =>
      (_$currentIndexComputed ??= Computed<int>(() => super.currentIndex,
              name: '_BottomNavigatorControllerBase.currentIndex'))
          .value;

  late final _$_currentIndexAtom = Atom(
      name: '_BottomNavigatorControllerBase._currentIndex', context: context);

  @override
  int get _currentIndex {
    _$_currentIndexAtom.reportRead();
    return super._currentIndex;
  }

  @override
  set _currentIndex(int value) {
    _$_currentIndexAtom.reportWrite(value, super._currentIndex, () {
      super._currentIndex = value;
    });
  }

  late final _$_BottomNavigatorControllerBaseActionController =
      ActionController(
          name: '_BottomNavigatorControllerBase', context: context);

  @override
  void setCurrentIndex(int value) {
    final _$actionInfo = _$_BottomNavigatorControllerBaseActionController
        .startAction(name: '_BottomNavigatorControllerBase.setCurrentIndex');
    try {
      return super.setCurrentIndex(value);
    } finally {
      _$_BottomNavigatorControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex}
    ''';
  }
}
