import 'package:book_app/core/status.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:book_app/modules/home/widgets/menu_drawer.dart';
import 'package:book_app/modules/posts/post_widget/post_shimmer_widget.dart';
import 'package:book_app/modules/posts/post_widget/post_tile.dart';
import 'package:book_app/modules/profiile/controller/profile_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, this.userId});
  static String route = '/profile';

  String? userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController controller = Modular.get();
  UserController userController = Modular.get();
  BottomNavigatorController navigator = Modular.get();
  FavoritasStore favoritasStore = Modular.get();

  bool isDonoDaConta = true;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    if(widget.userId != null) isDonoDaConta = (widget.userId == controller.userController.user.id);
    setState(() {});
    _init();
  }

  _init() async{
      if(!isDonoDaConta){
        user = await userController.getUser(userId: widget.userId);
      }
      setState(() {
        
      });
      await controller.getPostsByUserId(userId: widget.userId);
      await controller.getFavoritosByUserId(userId: widget.userId);
  }

  @override
Widget build(BuildContext context) {
  return DefaultTabController(
    length: 2,
    child: Scaffold(
      backgroundColor: Colors.white,
      endDrawer: isDonoDaConta ? Drawer(child: MenuDrawer()) : null,
      body: RefreshIndicator(
        onRefresh: () async => await _init(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(), // Isso garante que o RefreshIndicator funcione
          child: Column(
            children: [
              // Cabeçalho com SliverAppBar e CircleAvatar
              Container(
                height: 200.0, // Altura para simular a SliverAppBar
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey,
                        child: Text(
                          isDonoDaConta
                              ? controller.userController.user.name[0]
                              : user?.name[0] ?? '',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Conteúdo do perfil
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isDonoDaConta) SizedBox(width: 45),
                      Text(
                        isDonoDaConta
                            ? controller.userController.user.name
                            : user?.name ?? '',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      if (isDonoDaConta)
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
                                '${controller.myFavoritas.length}',
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
                              '0',
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
                              '0',
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
                  // Conteúdo do TabBarView
                  SizedBox(
                    height: 400, // Altura para cada TabBarView
                    child: TabBarView(
                      children: [
                        Observer(builder: (_) {
                          switch (controller.situacaoPost) {
                            case Status.SUCESSO:
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.myPosts.length,
                                itemBuilder: (context, index) {
                                  return PostTile(
                                    post: controller.myPosts[index],
                                  );
                                },
                              );
                            case Status.ERRO:
                              return Center(child: Text('Erro ao carregar posts'));
                            default:
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return PostShimmer();
                                },
                              );
                          }
                        }),
                        Observer(builder: (_) {
                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: controller.myFavoritas.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      controller.myFavoritas[index]
                                              .volumeInfo.imageLinks?.thumbnail ??
                                          'https://via.placeholder.com/150',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    controller.myFavoritas[index]
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
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
