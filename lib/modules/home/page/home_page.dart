import 'package:book_app/core/status.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/comment_post/controller/comment_controller.dart';
import 'package:book_app/modules/home/widgets/appbar.dart';
import 'package:book_app/modules/home/widgets/menu_drawer.dart';
import 'package:book_app/modules/posts/post_store.dart';
import 'package:book_app/modules/posts/post_widget/post_shimmer_widget.dart';
import 'package:book_app/modules/posts/post_widget/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  static const String route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostStore postStore = Modular.get();
  
  final userController = Modular.get<UserController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => postStore.init(),
      child: Scaffold(
          appBar: AppBarWidget(
            searchIsSelect: postStore.searchIsSelect, 
            hintText: 'Encontre uma pessoa',
            searchIconAction: (){
              postStore.searchIsSelect = !postStore.searchIsSelect;
              setState(() {
                
              });
            },
            backAction: () => {
              postStore.searchIsSelect = !postStore.searchIsSelect,
              setState(() {
                
              })
            },
            textFieldOnChanged: (value){}, 
            textFieldController: postStore.searchController,),
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
                      ),
                      
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
