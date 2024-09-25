// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailsController on _DetailsControllerBase, Store {
  late final _$bookAtom =
      Atom(name: '_DetailsControllerBase.book', context: context);

  @override
  Book? get book {
    _$bookAtom.reportRead();
    return super.book;
  }

  @override
  set book(Book? value) {
    _$bookAtom.reportWrite(value, super.book, () {
      super.book = value;
    });
  }

  late final _$storeAtom =
      Atom(name: '_DetailsControllerBase.store', context: context);

  @override
  BookStore get store {
    _$storeAtom.reportRead();
    return super.store;
  }

  @override
  set store(BookStore value) {
    _$storeAtom.reportWrite(value, super.store, () {
      super.store = value;
    });
  }

  @override
  String toString() {
    return '''
book: ${book},
store: ${store}
    ''';
  }
}
