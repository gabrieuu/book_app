import 'package:book_app/core/status.dart';
import 'package:book_app/core/themes.dart';
import 'package:book_app/model/dto/view_chats_dto.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:book_app/modules/search/widgets/book_tile.dart';
import 'package:book_app/shared/appbar.dart';
import 'package:book_app/shared/menu_drawer.dart';
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
    if (widget.userId != null)
      isDonoDaConta = (widget.userId == controller.userController.user.id);
    setState(() {});
    _init();
  }

  _init() async {
    if (!isDonoDaConta) {
      user = await userController.getUser(userId: widget.userId);
      setState(() {});
    }
    await controller.init(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: (widget.userId != null) ? true : false,
          backgroundColor: Themes.branco,
        ),
        backgroundColor: Colors.white,
        endDrawer: isDonoDaConta ? Drawer(child: MenuDrawer()) : null,
        body: RefreshIndicator(
            onRefresh: () async {
              await _init();
              setState(() {});
            },
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Container(
                        height: 100.0, // Altura para simular a SliverAppBar
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
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
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Modular.to.pushNamed(
                                        '/initial/profile/seguidores',
                                        arguments: 0);
                                  },
                                  child: Column(
                                    children: [
                                      Observer(builder: (_) {
                                        return Text(
                                          '${controller.quantidadeSeguidores}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }),
                                      Text(
                                        'Seguidores',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Modular.to.pushNamed(
                                        '/initial/profile/seguidores',
                                        arguments: 1);
                                  },
                                  child: Column(
                                    children: [
                                      Observer(builder: (_) {
                                        return Text(
                                          '${controller.quantidadeSeguindo}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }),
                                      Text(
                                        'Seguindo',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (!isDonoDaConta)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Observer(builder: (_) {
                                  return IconButton(
                                      onPressed: () async {
                                        await controller
                                            .seguirPessoa(user!.id!);
                                      },
                                      icon: Icon(
                                        (controller.isSeguindo)
                                            ? Icons.person_remove_alt_1_outlined
                                            : Icons.person_add_alt,
                                        color: (controller.isSeguindo)
                                            ? Themes.corPrincipalAppModoClaro
                                            : Colors.grey,
                                      ));
                                }),
                                IconButton(
                                    onPressed: () {
                                      Modular.to.pushNamed('/initial/chat/tela',
                                          arguments: ChatsViewDto(
                                              nomeDoUsuario: user!.name,
                                              usernameDoUsuario: user!.username,
                                              userId: user!.id!));
                                    },
                                    icon: Icon(
                                      Icons.chat_bubble_outline_sharp,
                                      color: Colors.green,
                                    ))
                              ],
                            ),
                          TabBar(
                            onTap: (value) {
                              controller.tabBarSelecionada = value;
                            },
                            tabs: [
                              Tab(
                                icon: Icon(
                                  Icons.text_fields_outlined,
                                ),
                              ),
                              Tab(icon: Icon(Icons.favorite)),
                            ],
                          ),
                          // Conteúdo do TabBarView
                          Observer(builder: (_) {
                            return SizedBox(
                              height: controller
                                  .getAlturaTabbar, // Altura para cada TabBarView
                              child: TabBarView(
                                children: [
                                  Observer(builder: (_) {
                                    switch (controller.situacaoPost) {
                                      case Status.SUCESSO:
                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: controller.myPosts.length,
                                          itemBuilder: (context, index) {
                                            return PostTile(
                                              post: controller.myPosts[index],
                                            );
                                          },
                                        );
                                      case Status.ERRO:
                                        return Center(
                                            child:
                                                Text('Erro ao carregar posts'));
                                      default:
                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: 1,
                                          itemBuilder: (context, index) {
                                            return PostShimmer();
                                          },
                                        );
                                    }
                                  }),
                                  Observer(builder: (_) {
                                    return ListView.builder(
                                      padding: const EdgeInsets.only(top: 10),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller.myFavoritas.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: BookTile(
                                              book: controller
                                                  .myFavoritas[index]),
                                        );
                                      },
                                    );
                                  }),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
