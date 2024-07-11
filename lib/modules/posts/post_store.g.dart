// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostStore on _PostStoreBase, Store {
  late final _$postsAtom = Atom(name: '_PostStoreBase.posts', context: context);

  @override
  ObservableList<PostModel> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(ObservableList<PostModel> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  late final _$situacaoPostAtom =
      Atom(name: '_PostStoreBase.situacaoPost', context: context);

  @override
  Status get situacaoPost {
    _$situacaoPostAtom.reportRead();
    return super.situacaoPost;
  }

  @override
  set situacaoPost(Status value) {
    _$situacaoPostAtom.reportWrite(value, super.situacaoPost, () {
      super.situacaoPost = value;
    });
  }

  late final _$situacaoPostUploadAtom =
      Atom(name: '_PostStoreBase.situacaoPostUpload', context: context);

  @override
  Status get situacaoPostUpload {
    _$situacaoPostUploadAtom.reportRead();
    return super.situacaoPostUpload;
  }

  @override
  set situacaoPostUpload(Status value) {
    _$situacaoPostUploadAtom.reportWrite(value, super.situacaoPostUpload, () {
      super.situacaoPostUpload = value;
    });
  }

  late final _$getPostsAsyncAction =
      AsyncAction('_PostStoreBase.getPosts', context: context);

  @override
  Future<void> getPosts() {
    return _$getPostsAsyncAction.run(() => super.getPosts());
  }

  late final _$addPostAsyncAction =
      AsyncAction('_PostStoreBase.addPost', context: context);

  @override
  Future<void> addPost() {
    return _$addPostAsyncAction.run(() => super.addPost());
  }

  late final _$curtirPostAsyncAction =
      AsyncAction('_PostStoreBase.curtirPost', context: context);

  @override
  Future<void> curtirPost(PostModel post) {
    return _$curtirPostAsyncAction.run(() => super.curtirPost(post));
  }

  late final _$isCurtidoAsyncAction =
      AsyncAction('_PostStoreBase.isCurtido', context: context);

  @override
  Future<bool> isCurtido(int idPost) {
    return _$isCurtidoAsyncAction.run(() => super.isCurtido(idPost));
  }

  late final _$getQuantidadeCurtidasAsyncAction =
      AsyncAction('_PostStoreBase.getQuantidadeCurtidas', context: context);

  @override
  Future<int> getQuantidadeCurtidas(int idPost) {
    return _$getQuantidadeCurtidasAsyncAction
        .run(() => super.getQuantidadeCurtidas(idPost));
  }

  @override
  String toString() {
    return '''
posts: ${posts},
situacaoPost: ${situacaoPost},
situacaoPostUpload: ${situacaoPostUpload}
    ''';
  }
}
