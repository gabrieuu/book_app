import 'package:book_app/app_store.dart';
import 'package:book_app/core/status.dart';
import 'package:book_app/model/comment_model.dart';
import 'package:book_app/model/postModel/post_model.dart';
import 'package:book_app/modules/comment_post/controller/comment_controller.dart';
import 'package:book_app/modules/comment_post/widgets/comment_tile.dart';
import 'package:book_app/modules/posts/post_widget/enhanced_post_tile.dart';
import 'package:book_app/modules/posts/post_widget/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class CommentPage extends StatefulWidget {
  CommentPage({super.key, required this.post});

  final PostModel post;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage>
    with TickerProviderStateMixin {
  CommentController controller = Modular.get();
  AppStore appStore = Modular.get();

  late AnimationController _headerAnimationController;
  late Animation<Offset> _headerAnimation;

  ScrollController _scrollController = ScrollController();
  FocusNode _commentFocusNode = FocusNode();
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    controller.postSelecionado = widget.post;
    controller.getComments(widget.post.id!);

    _headerAnimationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _headerAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeOutBack,
    ));

    _headerAnimationController.forward();
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _scrollController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  // ...existing code...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 1),
        child: SlideTransition(
          position: _headerAnimation,
          child: AppBar(
            title: Text(
              'Comentários',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: -0.5,
              ),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.arrow_back_ios_new, size: 16),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.more_vert, size: 16),
                ),
                onPressed: () {},
              ),
              SizedBox(width: 8),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.grey[200]!,
                      Colors.transparent
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.getComments(widget.post.id!);
              },
              color: Theme.of(context).primaryColor,
              child: CustomScrollView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 800),
                      tween: Tween(begin: 0.0, end: 1.0),
                      curve: Curves.easeOutQuart,
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(0, 30 * (1 - value)),
                          child: Opacity(
                            opacity: value,
                            child: Container(
                              margin: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 20,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(20),
                              child: Observer(builder: (_) {
                                return EnhancedPostTile(
                                    post: controller.postSelecionado!);
                              }),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Observer(
                    builder: (_) {
                      switch (controller.commentsLoading) {
                        case Status.CARREGANDO:
                          return SliverFillRemaining(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TweenAnimationBuilder<double>(
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    builder: (context, value, child) {
                                      return Transform.scale(
                                        scale: 0.5 + (0.5 * value),
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context).primaryColor,
                                          strokeWidth: 3,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 24),
                                  Text(
                                    'Carregando comentários...',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        case Status.SUCESSO:
                          if (controller.comments.isEmpty) {
                            return SliverFillRemaining(
                              child: Container(
                                margin: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      duration: Duration(milliseconds: 1200),
                                      tween: Tween(begin: 0.0, end: 1.0),
                                      curve: Curves.elasticOut,
                                      builder: (context, value, child) {
                                        return Transform.scale(
                                          scale: value,
                                          child: Container(
                                            padding: EdgeInsets.all(24),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[50],
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.chat_bubble_outline,
                                              size: 64,
                                              color: Colors.grey[300],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      "Ainda não há comentários",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      "Seja o primeiro a comentar!",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return TweenAnimationBuilder<double>(
                                    duration: Duration(
                                        milliseconds: 600 + (index * 100)),
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    curve: Curves.easeOutQuart,
                                    builder: (context, value, child) {
                                      return Transform.translate(
                                        offset: Offset(0, 20 * (1 - value)),
                                        child: Opacity(
                                          opacity: value,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: CommentTile(
                                              commentModel:
                                                  controller.comments[index],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                childCount: controller.comments.length,
                              ),
                            );
                          }
                        default:
                          return SliverFillRemaining(
                            child: Container(
                              margin: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline,
                                      size: 64, color: Colors.red[300]),
                                  SizedBox(height: 16),
                                  Text(
                                    "Erro ao carregar comentários",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red[600],
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () =>
                                        controller.getComments(widget.post.id!),
                                    child: Text('Tentar Novamente'),
                                  ),
                                ],
                              ),
                            ),
                          );
                      }
                    },
                  ),
                  // Add some bottom padding for keyboard space
                  SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                ],
              ),
            ),
          ),
          // Comment input area
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 12,
              bottom: MediaQuery.of(context).viewInsets.bottom > 0
                  ? 12
                  : MediaQuery.of(context).padding.bottom + 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 120, // Limita altura máxima
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[200]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: controller.commentInsert,
                      focusNode: _commentFocusNode,
                      maxLines: null,
                      maxLength: 500, // Limita caracteres
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Escreva seu comentário...',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                        counterText: '', // Remove contador de caracteres
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Observer(
                  builder: (_) {
                    return TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 200),
                      tween: Tween(
                        begin: 0.0,
                        end: controller.commentInsert.text.trim().isNotEmpty
                            ? 1.0
                            : 0.7,
                      ),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.8 + (0.2 * value),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () async {
                                if (controller.commentInsert.text
                                    .trim()
                                    .isNotEmpty) {
                                  await controller.addComments(appStore.currentUser?.id ?? '');
                                  _commentFocusNode.unfocus();
                                }
                              },
                              icon: Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 22,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 50,
                                minHeight: 50,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
// ...existing code...
}
