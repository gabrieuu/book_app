import 'package:book_app/model/post_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PostTile extends StatefulWidget {
  PostTile({super.key, required this.post});

  PostModel post;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  bool _isExpandable = false;
  
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
                    Text(widget.post.autorName!,
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
              padding: const EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
              child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          maxLines: _isExpandable ? null : 5,
                          text: TextSpan(children: [
                            TextSpan(
                                text: (!_isExpandable && widget.post.content.length >= 300)
                                    ? widget.post.content
                                    : widget.post.content.substring(0, widget.post.content.length),
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow:
                                      _isExpandable ? null : TextOverflow.ellipsis,
                                )),                 
                          ])),
                      if(widget.post.content.length > 300)
                        InkWell(
                          onTap: () {
                            _isExpandable = !_isExpandable;
                                setState(() {
                                });
                          },
                          child: Text(
                               _isExpandable ? 'ver menos' : 'ver mais',
                              style: TextStyle(color: Colors.blue),
                              ),
                        )
                    ],
                  )),
            ),
            
            if(widget.post.images != null) Row(
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
                IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border)),
                Text('null'),
                IconButton(onPressed: (){}, icon: Icon(Icons.comment_outlined)),
                Text('null'),
                IconButton(onPressed: (){}, icon: Icon(Icons.share_outlined)),
                Text('null'),
              ],
            )
          ],
        ),
      ),
    );
  }
}