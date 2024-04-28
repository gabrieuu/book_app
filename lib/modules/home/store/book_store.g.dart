// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BookStore on _BookStoreBase, Store {
  late final _$listBooksAtom =
      Atom(name: '_BookStoreBase.listBooks', context: context);

  @override
  List<Book> get listBooks {
    _$listBooksAtom.reportRead();
    return super.listBooks;
  }

  @override
  set listBooks(List<Book> value) {
    _$listBooksAtom.reportWrite(value, super.listBooks, () {
      super.listBooks = value;
    });
  }

  late final _$indexActionChipSelectAtom =
      Atom(name: '_BookStoreBase.indexActionChipSelect', context: context);

  @override
  int get indexActionChipSelect {
    _$indexActionChipSelectAtom.reportRead();
    return super.indexActionChipSelect;
  }

  @override
  set indexActionChipSelect(int value) {
    _$indexActionChipSelectAtom.reportWrite(value, super.indexActionChipSelect,
        () {
      super.indexActionChipSelect = value;
    });
  }

  late final _$searchIsSelectAtom =
      Atom(name: '_BookStoreBase.searchIsSelect', context: context);

  @override
  bool get searchIsSelect {
    _$searchIsSelectAtom.reportRead();
    return super.searchIsSelect;
  }

  @override
  set searchIsSelect(bool value) {
    _$searchIsSelectAtom.reportWrite(value, super.searchIsSelect, () {
      super.searchIsSelect = value;
    });
  }

  late final _$livrosCarregadosAtom =
      Atom(name: '_BookStoreBase.livrosCarregados', context: context);

  @override
  Status get livrosCarregados {
    _$livrosCarregadosAtom.reportRead();
    return super.livrosCarregados;
  }

  @override
  set livrosCarregados(Status value) {
    _$livrosCarregadosAtom.reportWrite(value, super.livrosCarregados, () {
      super.livrosCarregados = value;
    });
  }

  late final _$fetchAllBooksAsyncAction =
      AsyncAction('_BookStoreBase.fetchAllBooks', context: context);

  @override
  Future<void> fetchAllBooks(String book) {
    return _$fetchAllBooksAsyncAction.run(() => super.fetchAllBooks(book));
  }

  late final _$_BookStoreBaseActionController =
      ActionController(name: '_BookStoreBase', context: context);

  @override
  dynamic tornaLivroFavorito(Book book) {
    final _$actionInfo = _$_BookStoreBaseActionController.startAction(
        name: '_BookStoreBase.tornaLivroFavorito');
    try {
      return super.tornaLivroFavorito(book);
    } finally {
      _$_BookStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listBooks: ${listBooks},
indexActionChipSelect: ${indexActionChipSelect},
searchIsSelect: ${searchIsSelect},
livrosCarregados: ${livrosCarregados}
    ''';
  }
}
