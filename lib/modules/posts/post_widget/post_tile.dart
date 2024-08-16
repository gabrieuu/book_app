import 'package:book_app/model/post_model.dart';
import 'package:book_app/modules/comment_post/controller/comment_controller.dart';
import 'package:book_app/modules/posts/post_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PostTile extends StatefulWidget {
  PostTile({super.key, required this.post});

  PostModel post;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  bool _isExpandable = false;
  CommentController commentController = Modular.get();
  PostStore postStore = Modular.get();
  int? commentariosLength;
  bool isCurtido = false;
  int? curtidas;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      const NetworkImage('https://picsum.photos/250?image=9'),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.post.autorName ?? "autor",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    InkWell(
                      onTap: () {},
                      child: Text('Link Livro',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey)),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 5, top: 10, bottom: 10),
              child: SizedBox(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      maxLines: _isExpandable ? null : 5,
                      text: TextSpan(children: [
                        TextSpan(
                            text: (!_isExpandable &&
                                    widget.post.content.length >= 300)
                                ? widget.post.content
                                : widget.post.content
                                    .substring(0, widget.post.content.length),
                            style: TextStyle(
                              color: Colors.black,
                              overflow:
                                  _isExpandable ? null : TextOverflow.ellipsis,
                            )),
                      ])),
                  if (widget.post.content.length > 300)
                    InkWell(
                      onTap: () {
                        _isExpandable = !_isExpandable;
                        setState(() {});
                      },
                      child: Text(
                        _isExpandable ? 'ver menos' : 'ver mais',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                ],
              )),
            ),
<<<<<<< HEAD
            // if (widget.post.images != null)
            //   Row(
            //     children: [
            //       Expanded(
            //           child: SizedBox(
            //         height: 400,
            //         child: ListView(
            //           scrollDirection: Axis.horizontal,
            //           children: List.generate(
            //             widget.post.images!.length,
            //             (index) => Padding(
            //               padding: const EdgeInsets.only(right: 10),
            //               child: Container(
            //                 width: 300,
            //                 decoration: BoxDecoration(color: Colors.grey),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ))
            //     ],
            //   ),
            Observer(builder: (_) {
              return Row(
                children: [
                  IconButton(
=======
            if (widget.post.images != null)
              Row(
                children: [
                  Expanded(
                      child: SizedBox(
                    height: 400,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        widget.post.images!.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Container(
                            width: 300,
                            decoration: BoxDecoration(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    postStore.curtirPost(widget.post);
                    widget.post.isCurtido = !widget.post.isCurtido;
                    widget.post.quantidadeCurtidas = widget.post.isCurtido
                        ? widget.post.quantidadeCurtidas! + 1
                        : widget.post.quantidadeCurtidas! - 1;
                    setState(() {});
                  },
                  icon: Icon(widget.post.isCurtido
                      ? Icons.favorite
                      : Icons.favorite_border_outlined),
                  color: widget.post.isCurtido ? Colors.red : null,
                ),
                Text('${widget.post.quantidadeCurtidas ?? 0}'),
                IconButton(
>>>>>>> cd1aa647cc0f86823ae55a9b3214c5ed77754725
                    onPressed: () {
                      Modular.to
                          .pushNamed('/comment', arguments: widget.post);
                    },
                    icon: const Icon(Icons.comment_outlined)),
                Text('${widget.post.quantidadeComentarios ?? 0}'),
                // IconButton(onPressed: (){}, icon: Icon(Icons.share_outlined)),
                // Text('null'),
              ],
            ),
            Divider(
              color: Colors.grey, // Cor da linha
              height: 0, // Espaço vertical ao redor da linha
              thickness: 1, // Espessura da linha
            ),
          ],
        ),
      ),
    );
  }
}
