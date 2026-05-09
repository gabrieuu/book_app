import 'package:book_app/core/status.dart';
import 'package:book_app/core/themes.dart';
import 'package:book_app/model/dto/view_chats_dto.dart';
import 'package:book_app/model/user_model.dart';
import 'package:book_app/modules/favoritas/store/favoritas_store.dart';
import 'package:book_app/modules/home/controller/bottom_navigator_controller.dart';
import 'package:book_app/modules/posts/post_widget/enhanced_post_tile.dart';
import 'package:book_app/modules/profiile/widget/editar_perfil_widget.dart';
import 'package:book_app/modules/search/widgets/book_tile.dart';
import 'package:book_app/shared/menu_drawer.dart';
import 'package:book_app/modules/posts/post_widget/post_shimmer_widget.dart';
import 'package:book_app/modules/profiile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.userId});
  static String route = '/profile';

  final String? userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController controller = Modular.get();
  BottomNavigatorController navigator = Modular.get();
  FavoritasStore favoritasStore = Modular.get();

  UserModel? user;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    if (!isDonoDaConta) {
      user = await controller.getUser(widget.userId!);
      setState(() {});
    }
    await controller.init(widget.userId);
  }

  bool get isDonoDaConta {   
    if(widget.userId == null) return true;
    return controller.currentUser!.id == widget.userId;
  }
  

  @override
  Widget build(BuildContext context) {
    // Verificar se está carregando dados
    if (!isDonoDaConta && user == null) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Themes.branco),
        backgroundColor: Colors.white,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final userName = 
             controller.currentUser?.name ?? 'Usuário';

    final userInitial = controller.currentUser?.name[0] ?? '?';

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              _buildProfileAppBar(userInitial, userName),
              _buildStatsAndTabsHeader(),
            ];
          },
          body: _buildTabsBody(),
        ),
        endDrawer: isDonoDaConta ? Drawer(child: MenuDrawer()) : null,
      ),
    );
  }

  // AppBar com gradiente e informações do usuário
  Widget _buildProfileAppBar(String userInitial, String userName) {
    return SliverAppBar(
      expandedHeight: 280,
      floating: false,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: (widget.userId != null)
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      actions: [
        if(isDonoDaConta)
          TextButton(onPressed: (){
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              useRootNavigator: true,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: EditarPerfilWidget(),
                );
              },
            );
          }, child: const Text('Editar', style: TextStyle(color: Colors.white),) ),
        if (isDonoDaConta)
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.black87),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: _buildGradientHeader(userInitial, userName),
      ),
    );
  }

  // Header com gradiente e avatar
  Widget _buildGradientHeader(String userInitial, String userName) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 60),
            _buildAvatar(userInitial),
            const SizedBox(height: 16),
            _buildUserName(userName),
            const SizedBox(height: 4),
            _buildUserBio(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Avatar do usuário
  Widget _buildAvatar(String userInitial) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.white,
        child: Text(
          userInitial,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF667EEA),
          ),
        ),
      ),
    );
  }

  // Nome do usuário com botão de edição
  Widget _buildUserName(String userName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          userName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
       
      ],
    );
  }

  // Bio do usuário
  Widget _buildUserBio() {
    return const Text(
      'Amante de livros 📚',
      style: TextStyle(
        fontSize: 14,
        color: Colors.white70,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  // Header com estatísticas e tabs
  Widget _buildStatsAndTabsHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _ProfileStatsDelegate(
        minHeight: 200,
        maxHeight: 200,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              _buildStatisticsRow(),
              if (!isDonoDaConta && user != null) _buildActionButtons(),
              _buildTabBar(),
            ],
          ),
        ),
      ),
    );
  }

  // Linha de estatísticas
  Widget _buildStatisticsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Observer(builder: (_) {
            return _StatCard(
              count: controller.myPosts.length,
              label: 'Posts',
              icon: Icons.article_outlined,
              color: const Color(0xFF667EEA),
            );
          }),
          Observer(builder: (_) {
            return _StatCard(
              count: controller.myFavoritas.length,
              label: 'Favoritos',
              icon: Icons.favorite_border,
              color: const Color(0xFFE74C3C),
            );
          }),
          GestureDetector(
            onTap: () => Modular.to.pushNamed('/initial/profile/seguidores', arguments: 0),
            child: Observer(builder: (_) {
              return _StatCard(
                count: controller.quantidadeSeguidores,
                label: 'Seguidores',
                icon: Icons.people_outline,
                color: const Color(0xFF3498DB),
              );
            }),
          ),
          GestureDetector(
            onTap: () => Modular.to.pushNamed('/initial/profile/seguidores', arguments: 1),
            child: Observer(builder: (_) {
              return _StatCard(
                count: controller.quantidadeSeguindo,
                label: 'Seguindo',
                icon: Icons.person_add_outlined,
                color: const Color(0xFF2ECC71),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Botões de ação (seguir e chat)
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Expanded(child: _buildFollowButton()),
          const SizedBox(width: 12),
          _buildChatButton(),
        ],
      ),
    );
  }

  // Botão de seguir/deixar de seguir
  Widget _buildFollowButton() {
    return Observer(builder: (_) {
      return ElevatedButton.icon(
        onPressed: () async {
          if (user?.id != null) {
            await controller.seguirPessoa(user!.id!);
          }
        },
        icon: Icon(
          controller.isSeguindo ? Icons.person_remove_outlined : Icons.person_add_outlined,
          size: 18,
        ),
        label: Text(
          controller.isSeguindo ? 'Deixar de seguir' : 'Seguir',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: controller.isSeguindo ? Colors.grey[300] : const Color(0xFF667EEA),
          foregroundColor: controller.isSeguindo ? Colors.black87 : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      );
    });
  }

  // Botão de chat
  Widget _buildChatButton() {
    return ElevatedButton(
      onPressed: () {
        if (user?.id != null && user?.name != null && user?.username != null) {
          Modular.to.pushNamed('/initial/chat/tela',
              arguments: ChatsViewDto(
                  nomeDoUsuario: user!.name,
                  usernameDoUsuario: user!.username,
                  userId: user!.id!));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2ECC71),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: const Icon(Icons.chat_bubble_outline, size: 20),
    );
  }

  // TabBar
  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
        color: Colors.white
      ),
      child: TabBar(
        onTap: (value) {
          controller.tabBarSelecionada = value;
        },
        labelColor: const Color(0xFF667EEA),
        unselectedLabelColor: Colors.grey,
        indicatorColor: const Color(0xFF667EEA),
        indicatorWeight: 3,
        tabs: const [
          Tab(icon: Icon(Icons.grid_on), text: 'Posts'),
          Tab(icon: Icon(Icons.bookmark_border), text: 'Favoritos'),
        ],
      ),
    );
  }

  // Corpo das tabs
  Widget _buildTabsBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await _init();
        setState(() {});
      },
      child: Observer(builder: (_) {
        return TabBarView(
          children: [
            _buildPostsTab(),
            _buildFavoritesTab(),
          ],
        );
      }),
    );
  }

  // Tab de Posts
  Widget _buildPostsTab() {
    return Observer(builder: (_) {
      switch (controller.situacaoPost) {
        case Status.SUCESSO:
          if (controller.myPosts.isEmpty) {
            return _EmptyState(
              icon: Icons.article_outlined,
              message: isDonoDaConta ? 'Você ainda não fez nenhum post' : 'Nenhum post ainda',
              subtitle: isDonoDaConta ? 'Compartilhe suas leituras!' : '',
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: controller.myPosts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: EnhancedPostTile(post: controller.myPosts[index]),
              );
            },
          );
        case Status.ERRO:
          return _ErrorState(
            message: 'Erro ao carregar posts',
            onRetry: () => _init(),
          );
        default:
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: 3,
            itemBuilder: (context, index) => const PostShimmer(),
          );
      }
    });
  }

  // Tab de Favoritos
  Widget _buildFavoritesTab() {
    return Observer(builder: (_) {
      if (controller.myFavoritas.isEmpty) {
        return _EmptyState(
          icon: Icons.bookmark_border,
          message: isDonoDaConta ? 'Nenhum livro favoritado' : 'Nenhum favorito ainda',
          subtitle: isDonoDaConta ? 'Favorite seus livros preferidos!' : '',
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: controller.myFavoritas.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BookTile(book: controller.myFavoritas[index]),
          );
        },
      );
    });
  }
}

// Widget para cards de estatísticas
class _StatCard extends StatelessWidget {
  final int count;
  final String label;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.count,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(height: 8),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Widget para estado vazio
class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String subtitle;

  const _EmptyState({
    required this.icon,
    required this.message,
    this.subtitle = '',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 64, color: Colors.grey[400]),
          ),
          SizedBox(height: 24),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          if (subtitle.isNotEmpty) ...[
            SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ],
      ),
    );
  }
}

// Widget para estado de erro
class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          SizedBox(height: 16),
          Text(message, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onRetry,
            icon: Icon(Icons.refresh),
            label: Text('Tentar novamente'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF667EEA),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}

// Delegate para header persistente
class _ProfileStatsDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _ProfileStatsDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_ProfileStatsDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
