import 'package:book_app/model/post_model.dart';
import 'package:book_app/modules/comment_post/controller/comment_controller.dart';
import 'package:book_app/modules/posts/post_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class PostTile extends StatefulWidget {
  const PostTile({super.key, required this.post});

  final PostModel post;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  bool _isExpandable = false;
  PostStore postStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed('/initial/comment/', arguments: widget.post);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Modular.to.pushNamed('/initial/profile',
                          arguments: widget.post.autorId);
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: const NetworkImage(
                          'https://picsum.photos/250?image=9'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Modular.to.pushNamed('/initial/profile',
                              arguments: widget.post.autorId);
                        },
                        child: Text(widget.post.autorName ?? "autor",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text('Link Livro',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
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
                                overflow: _isExpandable
                                    ? null
                                    : TextOverflow.ellipsis,
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
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      postStore.curtirPost(widget.post);
                      widget.post.isCurtido = !widget.post.isCurtido;
                      widget.post.quantidadeCurtidas = widget.post.isCurtido
                          ? widget.post.quantidadeCurtidas + 1
                          : widget.post.quantidadeCurtidas - 1;
                      setState(() {});
                    },
                    icon: Icon(widget.post.isCurtido
                        ? Icons.favorite
                        : Icons.favorite_border_outlined),
                    color: widget.post.isCurtido ? Colors.red : null,
                  ),
                  Text('${widget.post.quantidadeCurtidas}'),
                  IconButton(
                      onPressed: () {
                        Modular.to.pushNamed('/initial/comment/',
                            arguments: widget.post);
                      },
                      icon: const Icon(Icons.comment_outlined)),
                  Text('${widget.post.quantidadeComentarios}'),
                  // IconButton(onPressed: (){}, icon: Icon(Icons.share_outlined)),
                  // Text('null'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
