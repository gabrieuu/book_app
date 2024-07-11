import 'package:book_app/model/comment_model.dart';
import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({super.key, required this.commentModel});

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      const NetworkImage('https://picsum.photos/250?image=9'),
                ),
                SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(commentModel.autorName!, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(commentModel.content),
              ],
            ),

          ],
        ),
      ),
    );
  }
}