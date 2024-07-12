import 'package:book_app/core/status.dart';
import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:book_app/modules/posts/post_widget/post_shimmer_widget.dart';
import 'package:book_app/modules/posts/post_widget/post_tile.dart';
import 'package:book_app/modules/profiile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  static String route = '/profile';

  ProfileController controller = Modular.get();
  BottomNavigatorController navigator = Modular.get();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    navigator.currentIndex = 0;
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                expandedHeight: 200.0,
                pinned: true,
                
                surfaceTintColor: Colors.blue,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Stack(
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue[200],                    
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                          child: Text(
                            controller.userController.user.name[0],
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 45),
                        Text(
                          controller.userController.user.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit, color: Colors.blue),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Photographer | Natural Lover',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Observer(builder: (_) {
                                return Text(
                                  '${controller.myPosts.length}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                              Text(
                                'Posts',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              Observer(builder: (_) {
                                return Text(
                                  '${controller.favoritasStore.listBooksFavorites.length}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                              Text(
                                'Favoritos',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              Text(
                                '1000',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Seguidores',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              Text(
                                '100',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Seguindo',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(
                            Icons.text_fields_outlined,
                          ),
                        ),
                        Tab(icon: Icon(Icons.book)),
                      ],
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Observer(builder: (_) {
                switch (controller.situacaoPost) {
                  case Status.SUCESSO:
                    return ListView.builder(
                      itemCount: controller.myPosts.length,
                      itemBuilder: (context, index) {
                        return PostTile(
                          post: controller.myPosts[index],
                        );
                      },
                    );
                  case Status.ERRO:
                    return Center(
                      child: Text('Erro ao carregar posts'),
                    );
                  default:
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return PostShimmer();
                      },
                    );
                }
              }),
              Observer(builder: (_) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount:
                      controller.favoritasStore.listBooksFavorites.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                          image: NetworkImage(
                            controller.favoritasStore.listBooksFavorites[index]
                                    .volumeInfo.imageLinks?.thumbnail ??
                                'https://via.placeholder.com/150',
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          controller.favoritasStore.listBooksFavorites[index]
                              .volumeInfo.title,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
