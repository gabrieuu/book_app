import 'package:book_app/core/status.dart';
import 'package:book_app/model/comment_model.dart';
import 'package:book_app/model/post_model.dart';
import 'package:book_app/modules/auth/controller/user_controller.dart';
import 'package:book_app/modules/comment_post/controller/comment_controller.dart';
import 'package:book_app/modules/comment_post/widgets/comment_tile.dart';
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

class _CommentPageState extends State<CommentPage> {
  CommentController controller = Modular.get();

  UserController user = Modular.get();

  @override
  void initState() {
    super.initState();
    controller.postSelecionado = widget.post;
    controller.getComments(widget.post.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Observer(builder: (_) {
              return PostTile(post: controller.postSelecionado!);
            }),
            Expanded(
              child: Observer(
                builder: (_) {
                  switch (controller.commentsLoading) {
                    case Status.CARREGANDO:
                      return Center(child: CircularProgressIndicator());
                    case Status.SUCESSO:
                      if (controller.comments.isEmpty) {
                        return Center(
                          child: Text("Nenhum Comentário adicionado"),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: controller.comments.length,
                          itemBuilder: (context, index) {
                            return CommentTile(
                                commentModel: controller.comments[index]);
                          },
                        );
                      }
                    default:
                      return Center(child: Text("erro"));
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: controller.commentInsert,
                  decoration: InputDecoration(
                      hintText: 'Comente algo',
                      hintStyle: TextStyle(fontSize: 13),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          await controller.addComments(user.user.id!);
                        },
                        icon: Icon(Icons.send),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
