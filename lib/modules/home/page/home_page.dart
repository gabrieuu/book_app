import 'package:book_app/core/status.dart';
import 'package:book_app/modules/home/widgets/menu_drawer.dart';
import 'package:book_app/modules/posts/post_store.dart';
import 'package:book_app/modules/posts/post_widget/post_shimmer_widget.dart';
import 'package:book_app/modules/posts/post_widget/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  PostStore postStore = Modular.get();

  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => postStore.init(),
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: const Text('Home Page'),
            surfaceTintColor: Colors.white,
          ),
          drawer: Drawer(
            child: MenuDrawer(),
          ),
          body: Observer(
            builder: (_) {
              switch (postStore.situacaoPost) {
                case Status.CARREGANDO:
                  return ListView.builder(
                      itemCount: 5, itemBuilder: (_, index) => PostShimmer());
                case Status.SUCESSO:
                  return Column(
                    children: [
                      if (postStore.situacaoPostUpload == Status.CARREGANDO)
                        PostShimmer(),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: postStore.posts.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Modular.to.pushNamed('/comment', arguments: postStore.posts[index]);
                              },
                              child: PostTile(post: postStore.posts[index]));
                          },
                        ),
                      )
                    ],
                  );
                default:
                  return const Center(child: Text('erro'));
              }
            },
          )),
    );
  }
}
